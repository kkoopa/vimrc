set encoding=utf-8
set number
set relativenumber
set colorcolumn=80
set hlsearch
set autowrite
set nojoinspaces
syntax on
highlight ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()
set showcmd
let mapleader=","
nnoremap <Leader>s :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <Leader>m :make<CR>

set completeopt+=noselect

filetype plugin on

"Go
au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = trim(system('go env GOPATH'), "\n").'/bin/gocode'
let g:deoplete#sources#go#cgo#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#cgo = 1
let g:deoplete#sources#go#cgo#std = 'c11'
let g:deoplete#sources#cgo#sort_algo = 'alphabetical'
let g:go_test_show_name = 1
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_auto_sameids = 1
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <leader>i <Plug>(go-info)
au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
"au FileType go map <C-K> :GoFmt<CR>
"au FileType go imap <C-K> <c-o>:GoFmt<CR>

"clang-format
au FileType c,cpp,objc map <C-K> :py3f /usr/local/share/clang/clang-format.py<CR>
au FileType c,cpp,objc imap <C-K> <c-o>:py3f /usr/local/share/clang/clang-format.py<CR>

"Markdown
au Filetype markdown set makeprg=open\ -a\ MacDown.app\ %

set exrc
set secure
