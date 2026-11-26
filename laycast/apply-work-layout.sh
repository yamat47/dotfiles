#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Apply Work Layout
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🪟
# @raycast.packageName Window Layout
# @raycast.description Slack を左半分、Chrome/Claude/iTerm2 を右半分に配置する

osascript -l JavaScript <<'EOF'
ObjC.import('AppKit');

// ===== 設定 =====
// 左列（Slack）の幅の比率。右列は残り全部
// 対象の画面が MacBook 本体のディスプレイなら MacBook 用の設定を使う
// （解像度の設定に関係なく判定。名前が取れないときだけ横幅で判定する）
const LEFT_RATIO_LARGE   = 0.5;  // 4K 27インチなど
const LEFT_RATIO_SMALL   = 0.5;  // MacBook 本体の画面
const SMALL_SCREEN_WIDTH = 1800; // pt（予備の判定用）
// MacBook の画面のとき、各アプリの表示を何段階小さくするか（0 で何もしない）
// 4K など大きい画面のときは、通常サイズ（⌘0）に戻す
const ZOOM_OUT_STEPS_SMALL = {
  'Slack':  3,
  'Claude': 1,
};
// ウィンドウ間のすき間（pt）。Raycast の Window Gap と揃えると見た目が統一される
const GAP = 0;

// 配置ルール：プロセス名 → 場所
// 場所: left / left-top / left-bottom / center / right / right-top / right-bottom
// 右半分の3つは同じ場所に重なるので、⌘Tab で切り替えて使う
const RULES = [
  { app: 'Slack',         slot: 'left' },
  { app: 'Google Chrome', slot: 'right' },
  { app: 'Claude',        slot: 'right' },
  { app: 'iTerm2',        slot: 'right' },
];
// ================

// 一番横幅の広いディスプレイ（4K 27インチを想定）を対象にする
const screens = $.NSScreen.screens;
const primaryH = screens.objectAtIndex(0).frame.size.height;
let target = screens.objectAtIndex(0);
for (let i = 1; i < screens.count; i++) {
  const s = screens.objectAtIndex(i);
  if (s.frame.size.width > target.frame.size.width) target = s;
}

// メニューバーと Dock を除いた領域を、左上原点の座標に変換
const vf = target.visibleFrame;
const X = vf.origin.x;
const Y = primaryH - (vf.origin.y + vf.size.height);
const W = vf.size.width;
const H = vf.size.height;

const screenName = ObjC.unwrap(target.localizedName) || '';
const isSmall = screenName
  ? /Built-in|内蔵/.test(screenName)
  : W < SMALL_SCREEN_WIDTH;
const LEFT_RATIO = isSmall ? LEFT_RATIO_SMALL : LEFT_RATIO_LARGE;
const leftW   = Math.round(W * LEFT_RATIO);
const rightW  = W - leftW;
const centerW = W - leftW - rightW;
const topH    = Math.round(H / 2);
const bottomH = H - topH;

const SLOTS = {
  'left':         [X, Y, leftW, H],
  'left-top':     [X, Y, leftW, topH],
  'left-bottom':  [X, Y + topH, leftW, bottomH],
  'center':       [X + leftW, Y, centerW, H],
  'right':        [X + leftW + centerW, Y, rightW, H],
  'right-top':    [X + leftW + centerW, Y, rightW, topH],
  'right-bottom': [X + leftW + centerW, Y + topH, rightW, bottomH],
};

const se = Application('System Events');

for (const rule of RULES) {
  const proc = se.processes.byName(rule.app);
  if (!proc.exists()) continue; // 起動していないアプリは飛ばす

  let [x, y, w, h] = SLOTS[rule.slot];
  x += GAP / 2; y += GAP / 2; w -= GAP; h -= GAP;

  // そのアプリの通常ウィンドウをすべて同じ場所に重ねる
  for (const win of proc.windows()) {
    try {
      if (win.subrole() !== 'AXStandardWindow') continue; // ダイアログ等は除外
      win.position = [x, y];
      win.size = [w, h];
      win.position = [x, y]; // サイズ変更で位置がずれるアプリ対策
    } catch (e) {
      // 最小化中・フルスクリーン中などで動かせないウィンドウは無視
    }
  }
}

// 各アプリの文字サイズを画面に合わせる（⌘0 で通常サイズに戻してから ⌘- で縮小）
// キー入力は前面のアプリに届くため、一瞬ずつ各アプリを前面に出し、最後に元のアプリに戻す
const front = se.processes.whose({ frontmost: true })[0].name();
for (const [app, steps] of Object.entries(ZOOM_OUT_STEPS_SMALL)) {
  if (steps <= 0) continue;
  const proc = se.processes.byName(app);
  if (!proc.exists()) continue;

  proc.frontmost = true;
  // 本当に前面に来るまで待つ（最大 2 秒）
  for (let i = 0; i < 20 && !proc.frontmost(); i++) delay(0.1);
  delay(0.3); // 前面に来た直後のキー入力の取りこぼしを防ぐ
  // 文字ではなくキーコードで送る（日本語入力中や JIS キーボードでも確実に届くように）
  // 29 = 「0」キー, 27 = 「-」キー
  se.keyCode(29, { using: 'command down' });
  if (isSmall) {
    for (let i = 0; i < steps; i++) {
      delay(0.1);
      se.keyCode(27, { using: 'command down' });
    }
  }
  delay(0.3); // 縮小が反映される前に次のアプリへ移らないよう待つ
}
se.processes.byName(front).frontmost = true;

// 実行結果を Raycast の通知に表示（どちらのモードで動いたか確認できる）
`レイアウト適用：${isSmall ? 'MacBook 用' : '大画面用'}（${screenName || '不明な画面'}・幅 ${Math.round(W)}pt）`;
EOF
