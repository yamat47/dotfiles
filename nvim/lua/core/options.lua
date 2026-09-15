local o          = vim.opt

o.clipboard      = "unnamedplus"
o.swapfile       = false
o.undofile       = true
o.shadafile      = vim.fn.stdpath("state") .. "/shada/main.shada"

o.number         = true
o.signcolumn     = "yes:2"
o.cursorline     = true
o.termguicolors  = true
o.pumblend       = 10

o.tabstop        = 2
o.shiftwidth     = 2
o.expandtab      = true
o.smartindent    = true
o.wrap           = false
o.scrolloff      = 8
o.sidescrolloff  = 8

o.ignorecase     = true
o.smartcase      = true
o.inccommand     = "nosplit"
o.grepprg        = "rg --vimgrep --smart-case --hidden"
o.grepformat     = "%f:%l:%c:%m"

o.lazyredraw     = true
o.updatetime     = 250
o.timeoutlen     = 400
o.mousemoveevent = true

o.binary         = false
o.fixendofline   = true
