call plug#begin()

set number

command! Ct :belowright split | resize 15 | terminal bash -c "cd %:p:h && exec bash"

" Function to toggle between text and terminal windows while staying in insert mode.
function! ToggleTerminalSwitch() abort
  " Check if the current buffer is a terminal.
  if &buftype ==# 'terminal'
    " We're in the terminal, so go back to our stored text window.
    if exists('g:last_text_win') && win_id2win(g:last_text_win) != 0
      call win_gotoid(g:last_text_win)
    else
      " Fallback to the previous window.
      wincmd p
    endif
    " Re-enter insert mode in the text window.
    startinsert
  else
    " We're in a text buffer. Save this window's ID for later.
    let g:last_text_win = win_getid()
    " Look for an existing terminal window in the current tab.
    let term_win = 0
    for w in range(1, winnr('$'))
      if getbufvar(winbufnr(w), '&buftype') ==# 'terminal'
        let term_win = w
        break
      endif
    endfor
    if term_win == 0
      " No terminal window found; open one in a split.
      belowright split | terminal
    else
      " Switch to the terminal window.
      execute term_win . "wincmd w"
    endif
    " Enter insert mode in the terminal.
    startinsert
  endif
endfunction

" Map F12 to toggle the terminal from insert mode in text buffers.
inoremap <F12> <C-o>:call ToggleTerminalSwitch()<CR>
" Map F12 to toggle back from terminal mode.
" In terminal mode we first leave terminal's insert mode with <C-\><C-n>.
tnoremap <F12> <C-\><C-n>:call ToggleTerminalSwitch()<CR>


" ========= Nano Keybindings =========
" ^G: Help
nnoremap <C-g> :help<CR>
inoremap <C-g> <C-o>:help<CR>

" ^X: Exit
nnoremap <C-x> :q<CR>
inoremap <C-x> <C-o>:q<CR>

" ^O: Write Out (Save file)
nnoremap <C-o> :w<CR>
inoremap <C-o> <C-o>:w<CR>

" ^R: Read File (Insert file at cursor)
nnoremap <C-r> :execute 'read ' . input('Read file: ')<CR>
inoremap <C-r> <C-o>:execute 'read ' . input('Read file: ')<CR>

" ^W: Where Is (Search)
nnoremap <C-w> /
inoremap <C-w> <C-o>/

" ^Y: Previous Page (Page up)
nnoremap <C-y> <C-b>
inoremap <C-y> <C-o><C-b>

" ^V: Next Page (Page down)
nnoremap <C-v> <C-f>
inoremap <C-v> <C-o><C-f>

" ^K: Cut/Delete
" In normal mode: delete the current line.
nnoremap <C-k> dd
" In insert mode: delete the current line (via a temporary normal mode command).
inoremap <C-k> <C-o>dd
" In visual mode: delete the selected text.
vnoremap <C-k> d

" ^U: Uncut (Paste the last cut text)
nnoremap <C-u> p
inoremap <C-u> <C-o>p

" ^J: Justify (Format the current paragraph)
nnoremap <C-j> gqap
inoremap <C-j> <C-o>gqap

" ^C: Show Cursor Position
nnoremap <M-c> :echo "Line: " . line('.') . ", Col: " . col('.')<CR>
inoremap <M-c> <C-o>:echo "Line: " . line('.') . ", Col: " . col('.')<CR>

" ^T: Spell Check Toggle
nnoremap <C-t> :setlocal spell!<CR>
inoremap <C-t> <C-o>:setlocal spell!<CR>

" ^_: Go To Line
nnoremap <C-_> :execute "normal! " . input("Go to line: ") . "G"<CR>
inoremap <C-_> <C-o>:execute "normal! " . input("Go to line: ") . "G"<CR>

" ^\ : Replace (start a search & replace command)
nnoremap <C-\> :%s///g<Left><Left><Left>
inoremap <C-\> <C-o>:%s///g<Left><Left><Left>

" M-U: Undo (Alt+U)
nnoremap <M-u> u
inoremap <M-u> <C-o>u

" M-E: Redo (Alt+E)
nnoremap <M-e> <C-r>
inoremap <M-e> <C-o><C-r>

" ========= Toggle Selection Mode (Marking) =========
" Press Ctrl+6 (Ctrl+^) to toggle visual selection.
" - In normal mode: it starts visual mode.
" - In visual mode: it exits back to normal mode.
nnoremap <C-^> v
vnoremap <C-^> <Esc>
inoremap <C-^> <C-o>v

" ========= Go to Top/Bottom of File =========
" Alt-\ : Go to the top of the file
nnoremap <M-\> gg
inoremap <M-\> <C-o>gg

" Alt-/ : Go to the bottom of the file
nnoremap <M-/> G
inoremap <M-/> <C-o>G

" Map Ctrl+S to save (write out) in normal, insert, and visual modes.
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>
vnoremap <C-s> <Esc>:w<CR>
