## calonaur's dotfiles - setup.sh
#
#  designed to be compatible with out the box macOS / debian
#  bash && vim 8.0 / nvim
#  

## links

# from = to
declare -A links=(
  [bashrc] = bashrc
  [profile] = bash_profile
  [profile] = profile
  [hushlogin] = hushlogin
  [gitconfig] = gitconfig
  [gitignore] = gitignore
  [vimrc] = vimrc 
  [tmux.conf] = tmux.conf
  [bin] = local
)

for from in "${links[@]}"; do
  ln -s "$PWD/${links[$from]}" "$HOME/.$from"
done
