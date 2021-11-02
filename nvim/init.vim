
" --  Shortcut Keys -- 
nnoremap <C-t> :NERDTree<CR>

" -- LightLine Status bar -- 
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

set noshowmode " hide mode message

" -- init code completion --
let g:deoplete#enable_at_startup = 1

" -- start gruvbox theme --
autocmd vimenter * ++nested colorscheme gruvbox

" Reverse default cycle order of Supertab so that
" <Tab> cycles forards and <S-Tab> cycle backward
let g:SuperTabDefaultCompletionType = "<c-n>"


" -- Linting and prettier integration with ALE --
let g:ale_fixers = {}
let g:ale_fixers.html = ['prettier']
let g:ale_fixers.javascript = ['prettier','eslint']
let g:ale_fixers.css = ['prettier','eslint']
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_javascript_prettier_options = '--use-spaces'

" let g:ale_fixers = {
" \   'javascript': ['prettier'],
" \   'css': ['prettier'],
" \}

" run ALE on save
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'


" ***********************
" *       vim-plug      *
" ***********************
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
" Plug 'HerringtonDarkholme/yats.vim' " typescript
" Plug 'yuezk/vim-js'
" Plug 'maxmellon/vim-jsx-pretty'
Plug 'ervandew/supertab'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
