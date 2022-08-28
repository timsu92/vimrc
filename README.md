# vimrc: my vim settings
Note! This is a config file on Ubuntu 22.04 on WSL2. If you use another system, you may need some changes to it.
## Plugins
### Plugins installed using [vim-plug](https://github.com/junegunn/vim-plug)
[✓] [**coc**](https://github.com/neoclide/coc.nvim): Code linting, code complete, error checking and more!  
[✓] [**vim-easy-align**](https://github.com/junegunn/vim-easy-align): Align your code with ease  
[✓] [**nerdcommenter**](https://github.com/preservim/nerdcommenter): Comment code with ease  
[✗] [**grayout.vim**](https://github.com/mphe/grayout.vim): (disabled as coc can do the job)Grayout unused code in `#` preprocessor blocks of C/C++  
[✓] [**FastFold**](https://github.com/Konfekt/FastFold): Recognizes languages and create folds  
[✗] [**tagbar**](https://github.com/preservim/tagbar): Navigate around code (disabled currently as I'm not using it)  
[✓] [**vim-stay**](https://github.com/zhimsel/vim-stay): Memorized page position, cursor position, folds' status  
[✗] [**vim-javascript**](https://github.com/pangloss/vim-javascript): JavaScript bundle for vim (Never used. Disabled currently)  
[✓] [**rainbow**](https://github.com/luochen1990/rainbow): Colorful parentheses, brackets... for locate with ease  
[✓] [**easymotion**](https://github.com/easymotion/vim-easymotion): Move your cursor faster and easier  
[✓] [**nerdtree**](https://github.com/preservim/nerdtree): File explorer  
[✓] [**nerdtree-git-plugin**](https://github.com/Xuyuanp/nerdtree-git-plugin): Show Git status in NERDTree  
[✓] [**vim-devicons**](https://github.com/ryanoasis/vim-devicons): Prettified icons for various file types  
[✓] [**vim-surround**](https://github.com/tpope/vim-surround): Manipulate parentheses, brackets... around texts  
[▲] [**vim-expand-region**](https://github.com/terryma/vim-expand-region): Expand and shrink selection somewhat like IntelliJ's [Select code constructs](https://www.jetbrains.com/help/idea/working-with-source-code.html#editor_code_selection), but can be improved  
[✓] [**vim-textobj-user**](https://github.com/kana/vim-textobj-user): Define `textobj` on your own  
[✓] [**vim-textobj-line**](https://github.com/kana/vim-textobj-line): Make entire line as `textobj`s  
[✓] [**VimSpector**](https://github.com/puremourning/vimspector): Debug right in Vim  
[✓] [**vim-snippets**](https://github.com/honza/vim-snippets): Snippets for expressing ideas in few key strokes  
[✓] [**endwise.vim**](https://github.com/tpope/vim-endwise): Close pairs when hitting `<enter>` in insert mode  
### Other plugins or functions
[✓] [**vim-monokai**](https://github.com/crusoexia/vim-monokai): Beautiful dark theme  
[✓] [**Powerline**](https://github.com/powerline/powerline): Multi-function status line  
[▲] **line mover**: Move line using `ctrl+UP` and `ctrl+DOWN`. (Indentation might be wrong)  
[✓] **WSL yank**: Copy yanked content to Windows clipboard w/o installing other programs  
[✓] **matchit.vim**: Use % to jump between correspond surrounds and if, else if, else  
[✓] [**fzf**](https://github.com/junegunn/fzf): The fuzzy finder  

## Installation
### Node.js
This guide allows you to install Node.js using nvm
#### step 1: Install cURL
```bash
sudo apt install curl
```
#### step 2: Select the desired version of nvm
[GitHub page](https://github.com/nvm-sh/nvm/releases)
#### step 3: Install nvm
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/<version>/install.sh | bash
```
for example
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```
#### step4: Check nvm installation
```bash
command -v nvm
```
This should gives you `nvm`. If it fails to do so, please take a look at [their GitHub page](https://github.com/nvm-sh/nvm)
#### step5: List installed Node.js (there should be no any at the moment)
```bash
nvm ls
```
![example output](https://docs.microsoft.com/zh-tw/windows/images/nvm-no-node.png)
*credit goes to Microsoft*
#### step6: Install Node.js
way1: install LTS-version
```bash
nvm install --lts
```
way2: install newest version (may contain bugs)
```bash
nvm install node
```
#### step7: Check Node.js status
```bash
nvm ls
```
Now, you should be able to see it.  
![example output](https://docs.microsoft.com/zh-tw/windows/images/nvm-node-installed.png)
*credit goes to Microsoft*

### PowerLine
#### step1: Change directory to a place your WSL distro can reach
#### step2: Get PowerLine
```bash
git clone https://github.com/powerline/powerline.git
```
#### step3: Move to it
```bash
cd powerline
```
#### step4(optional, recommended): switch to a newest version of release, instead of devlopement one
```bash
git checkout $(git rev-list --tags --max-count=1)
```
> The above line receives hash of the last release commit, and make the files conform with it
#### step5: Install
```bash
pip install -e .
```
#### step6: Make executables visible
Put this line in your `.bashrc` or something alike
```bash
export PATH="$HOME/.local/bin:$PATH"
```
#### step7: Get font
Follow [their guide](https://powerline.readthedocs.io/en/latest/installation.html#fonts-installation) to get a font. Then, change settings of your Windows Terminal
#### step8(optional): turn on the daemon
If you use git, it's nice to turn it on to improve performance a lot. To do so, put this in your `.bashrc` or something alike.
```bash
powerline-daemon -q
```
#### step9: restart your terminal or source `.bashrc`

### Depency of grayout
#### step1: Install `libclang1`
```bash
sudo apt install libclang1
```
#### step2: Move to the folder
```bash
cd /usr/lib/llvm-<version appropriate>/lib
```
for example
```bash
cd /usr/lib/llvm-14/lib
```
#### step3: Alias the lib
```bash
sudo ln -s libclang.so.1 libclang.so
```

### Plugins using [vim-plug](https://github.com/junegunn/vim-plug)
#### step1: Enter your Vim
#### step2: Upgrade [vim-plug](https://github.com/junegunn/vim-plug) itself by `:PlugUpgrade`
#### step3: In normal mode, type `:PlugInstall` to get plugins
#### step4: Restart Vim

### Clangd of coc
#### step1: Enter your Vim
#### step2: In normal mode, type `:CocCommand clangd.install`

### fzf
Personally, I use `git` to pull newest releases. Head over [their guide](https://github.com/junegunn/fzf#using-git) and everything explained

### VimSpector
#### linux
1. It seems that it's recommended to use GDB rather than LLDB on linux
```sh
sudo apt install gdb
```
2. If you want to use default settings for C/C++/C#/Rust, link the file to appropriate location
```sh
cd ~/.vim/plugged/vimspector/configurations/linux/_all
ln -s ../../../../../vimspector.json vimspector.json
```
