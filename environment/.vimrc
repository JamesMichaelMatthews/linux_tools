
"use vim pathogen for plugins (see the github page)
"  Install:
"    mkdir ~/.vim
"    cd ~/.vim
"    git clone https://github.com/tpope/vim-pathogen
" OR git clone https://github.com/JamesMichaelMatthews/vim-pathogen
"    ln -s ./vim-pathogen/autoload autoload
execute pathogen#infect()
"
"for clang_complete
"  Install:
"    mkdir ~/.vim/bundle
"    cd ~/.vim/bundle
"    git clone https://github.com/Rip-Rip/clang_complete
" OR git clone https://github.com/JamesMichaelMatthews/clang_complete
"    sudo apt-get install libclang-3.3-dev
"  To use this create .clang_complete files with
"   cmake by cd'ing into the build folder and running
"       CC='/home/user/.vim/bundle/clang_complete/bin/cc_args.py gcc' \
"       CXX='/home/user/.vim/bundle/clang_complete/bin/cc_args.py g++' \
"       cmake ..
"   and then move all of these files from the build folder
"   and into the source folder using 
"       find . -type f -name .clang_complete -exec cp \{\} ../\{\}\;
"   which simply copies them into the same hierarchy one folder up 
"   from build, which is (or should be) the source folder.
"   Also, don't forget to run "make".
"  We must se the path to the libclang.so
:let g:clang_library_path='/usr/lib/llvm-3.3/lib/'
"  change defaults, to stop tag annoyances (def/decl trouble, speed)
"    just change ']' to '}' in case I want to use them
:let g:clang_jumpto_declaration_key='<C-}>'
:let g:clang_jumpto_declaration_in_preview_key='<C-W>}'
"    leave this the same, for now
:let g:clang_jumpto_back_key='<C-T>'
"  turn on snippets for function arguments
let g:clang_snippets=1
"    disallow concealing snippets (also, allow only works with clang_complete engine)
let g:clang_snippets_engine='clang_complete'
let g:clang_conceal_snippets=0
"    set the vim conceal level, needed if concealing snippets (0: none, 3: completely, see the help)
set conceallevel=0
"    tell vim what modes to conceal under the cursor (visual, insert, normal)
set concealcursor=vin
"  turn off the scratch buffer, and limit the height
set completeopt=menu,menuone
set pumheight=20
"
"for supertab
"  Install:
"    cd ~/.vim/bundle
"    git clone https://github.com/ervandew/supertab
" OR git clone https://github.com/JamesMichaelMatthews/supertab
"  Fall back to super tab for completion.
:let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'
"
"for ctags
"  Install:
"    sudo apt-get install exuberant-ctags
"  To get tags for your source, call from the top source folder.
"    ctags -R --c-kinds=+p .
"  tell vim to look into parent folders for the tags file (the ;)
:set tags=./tags;
"  cycle in and out of tags easier
"  go to the first tag, and create the tag list
:nnoremap } <C-]>
:vnoremap } <C-]>
"  go to the next tag in the tag list
:nnoremap }} :tnext<CR>
:vnoremap }} :tnext<CR>
"  go to the prev in the tag list
:nnoremap {{ :tprev<CR>
:vnoremap {{ :tprev<CR>
"  back to prev position
:nnoremap { <C-t>
:vnoremap { <C-t>
"
"also, go get NERDTree
"  Install:
"    cd ~/.vim/bundle
"    git clone https://github.com/scrooloose/nerdtree
" OR git clone https://github.com/JamesMichaelMatthews/nerdtree
"    
"
"Doxygen comments
"  Install:
"    cd ~/.vim/bundle
"    git clone https://github.com/vim-scripts/DoxygenToolkit.vim
" OR git clone https://github.com/JamesMichaelMatthews/DoxygenToolkit.vim

"turn on color, allow normal backspaces
:syntax on
:set backspace=indent,eol,start

"indent settings
:vmap > >gv
:vmap < <gv
:set expandtab
:set shiftwidth=2

"make all yanks go into the 0 register
:nnoremap yy "0yy
:vnoremap y "0y
"make all deletes go into the 0 register
:nnoremap dd "0dd
:vnoremap d "0d
"make all pastes come from the 0 register
:nnoremap p "0p
:nnoremap P "0P
:vnoremap p "0p
:vnoremap P "0P

"make it easier to move between windows
:nnoremap J <C-w>j
:nnoremap K <C-w>k
:nnoremap H <C-w>h
:nnoremap L <C-w>l

"make it easier to resize windows
:nnoremap - <C-w>-
:nnoremap + <C-w>+
:nnoremap = <C-w>=
:nnoremap < <C-w><
:nnoremap > <C-w>>

"  NOTE: the ^M is literally one character, not two.
"        It is the newline, to literally run a command.
"        To insert it, type ctrl-v <enter>.

"store a macro to set the editing window for :Explore
"  but nerdtree is better
:let @e=':let g:netrw_chgwin=winnr()'

"Set the background color to indicate 80 characters.
"  Set the color
:highlight ColorColumn ctermbg=7 guibg=#888888
"  Set the columns that will be colored
"  Note that colorcolumn is a comma seperated list of ALL column numbers
":set colorcolumn=80
"    OR
":let &colorcolumn=join(range(81,999),",")
"  Set a macro
":let @c=':let &colorcolumn=join(range(81,999),",")'
"  Set Script Local functions and command mappings
:command EightyHighlightOn :call <SID>EightyHighlightOn()
:command EightyHighlightOff :call <SID>EightyHighlightOff()
:command EightyHighlight :call <SID>EightyHighlight()
function! s:EightyHighlightOn()
  :let w:eightyon=1
  :let &l:colorcolumn=join(range(81,999),",")
endfunction
function! s:EightyHighlightOff()
  if exists('w:eightyon')
    :unlet w:eightyon
  endif
  :let &l:colorcolumn=""
endfunction
function! s:EightyHighlight() "Toggle
  if exists('w:eightyon')
    :call <SID>EightyHighlightOff()
  else
    :call <SID>EightyHighlightOn()
  endif
endfunction

