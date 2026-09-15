# Machine-specific setup lives in ~/.zprofile; everything here is meant to be
# shared across machines. Files are loaded in numeric order because some of
# them depend on each other (see the comments inside 20/40).
for _f in "$HOME"/.zsh/[0-9][0-9]-*.zsh; do
  source "$_f"
done
unset _f
