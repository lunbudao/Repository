call plug#begin(stdpath('data') . '/plugged')
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } | Plug 'zchee/deoplete-jedi' | Plug 'davidhalter/jedi-vim'

" Theme
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs' | Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat' " seems do nothing

" TeX
Plug 'lervag/vimtex' | Plug 'vim-syntastic/syntastic'

" Markdown
Plug 'junegunn/goyo.vim' | Plug 'junegunn/limelight.vim'
" tabular plugin is used to format tables
Plug 'godlygeek/tabular'
" JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
call plug#end()

" vim-markdown

" disable header folding
let g:vim_markdown_folding_disabled = 1
" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0 
" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1
"support front matter of various format
let g:vim_markdown_frontmatter = 1 " for YAML format
let g:vim_markdown_toml_frontmatter = 1 " for TOML format
let g:vim_markdown_json_frontmatter = 1 " for JSON format
let g:mkdp_auto_close = 0
let g:vimtex_compiler_progname = 'nvr'
nnoremap <M-m> :MarkdownPreview<cr>

augroup pandoc_syntax
	au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup end

" goyo & limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" deoplete & jedi
let g:deoplete#enable_at_startup = 1
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = 'right'
"set splitbelow
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"let g:airline_theme='<theme>' " <theme> is a valid theme name
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" theme
colorscheme gruvbox
set background=dark " use dark mode
"set background=light " uncomment to use light mode

" ultisnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsEditSplit='horizontal'

" synthetic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" airline_theme
let g:airline_theme='simple'

let mapleader = "\\"
let maplocalleader = "-"

let g:python_host_prog = 'C:/Users/Genrry/miniconda3/envs/neovim2/python'
let g:python3_host_prog = 'C:/Users/Genrry/miniconda3/envs/neovim3/python'
let g:NERDTreeGitStatusUseNerdFonts = 1 " you should install nerdfonts by yourself. default: 0
"let g:NERDTreeGitStatusShowIgnored = 1 " a heavy feature may cost much more time. default: 0

let g:vimtex_enabled = 1
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
" settings for sumatraPDF
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options =
	\ '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
call deoplete#custom#var('omni', 'input_patterns', {
	\ 'tex': g:vimtex#re#deoplete
	\})

nnoremap <f2> :NERDTreeToggle<cr>
inoremap <f2> <esc>:NERDTreeToggle<cr>
nnoremap <leader>ev :exe 'split '.stdpath('config').'/init.vim'<cr>
nnoremap <leader>sv :exe 'source '.stdpath('config').'/init.vim'<cr>

set number
set relativenumber

function! SetServerName()
	if has('win32')
		let nvim_server_file = $TEMP . "/curnvimserver.txt"
	else
		let nvim_server_file = "/tmp/curnvimserver.txt"
	endif
	let cmd = printf("echo %s > %s", v:servername, nvim_server_file)
	call system(cmd)
endfunction

augroup vimtex_common
	autocmd!
	autocmd FileType tex call SetServerName()
augroup end

nnoremap <c-left> :tabprevious<cr>
nnoremap <c-right> :tabnext<cr>
