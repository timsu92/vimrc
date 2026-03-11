#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

cd ~
ln -sTf "$SCRIPT_DIR/.vimrc" ~/.vimrc
ln -snf "$SCRIPT_DIR/.vim" ~/.vim

# vim-plug plugins
vim -c 'PlugInstall' -c 'sleep 3' -c 'qa' 2>"$SCRIPT_DIR/pluginstall.stderr.log" >"$SCRIPT_DIR/pluginstall.stdout.log"

# coc extensions
vim -c 'execute "CocInstall -sync " . join(g:coc_global_extensions, " ")' -c 'qa' 2>"$SCRIPT_DIR/coc.stderr.log" >"$SCRIPT_DIR/coc.stdout.log"
