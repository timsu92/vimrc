#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-${(%):-%x}}")" && pwd)"

cd ~
ln -sTf "$SCRIPT_DIR/.vimrc" ~/.vimrc
ln -snf "$SCRIPT_DIR/.vim" ~/.vim

# vim-plug plugins
vim -c 'PlugInstall' -c 'sleep 3' -c 'qa'

# coc extensions
vim -c 'execute "CocInstall -sync " . join(g:coc_global_extensions, " ")' -c 'qa'
