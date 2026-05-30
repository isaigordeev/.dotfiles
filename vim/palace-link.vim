" ============================================================
"  palace-link.vim — wiki-link picker for palace notes
" ============================================================
" <leader>nl in normal mode:
"   1. fzf-picks any file under $PALACE_DIR (recursive)
"   2. inserts [[name]] at the cursor in the current buffer
"      (name = basename without .md, or basename.ext for non-md)
"   3. appends a backlink [[current-buffer-name]] at the end of
"      the selected file, separated by two blank lines
"
" Sourced from both vim/.vimrc and nvim/init.lua.

function! s:link_name(file) abort
   let l:base = fnamemodify(a:file, ':t')
   if l:base =~? '\.md$'
      return fnamemodify(a:file, ':t:r')
   endif
   return l:base
endfunction

function! s:palace_link_sink(picked) abort
   if empty(a:picked)
      return
   endif

   " Resolve to absolute path
   let l:target = a:picked
   if l:target[0] != '/'
      let l:target = $PALACE_DIR . '/' . l:target
   endif

   " Names
   let l:fwd  = s:link_name(l:target)
   let l:cur  = expand('%:t')
   if empty(l:cur)
      echohl WarningMsg | echo "palace-link: current buffer has no name; skipping backlink" | echohl None
      let l:back = ''
   else
      let l:back = s:link_name(expand('%:p'))
   endif

   " Insert [[fwd]] at cursor in current buffer, then save
   execute "normal! a[[" . l:fwd . "]]"
   if !empty(expand('%'))
      silent! write
   endif

   " Append backlink to target file (two blank lines for spacing)
   if !empty(l:back)
      call writefile(['', '', '[[' . l:back . ']]'], l:target, 'a')
   endif
endfunction

function! PalaceLink() abort
   if empty($PALACE_DIR)
      echohl ErrorMsg | echo "palace-link: PALACE_DIR not set" | echohl None
      return
   endif
   if !isdirectory($PALACE_DIR)
      echohl ErrorMsg | echo "palace-link: $PALACE_DIR not found" | echohl None
      return
   endif
   if !exists('*fzf#run')
      echohl ErrorMsg | echo "palace-link: fzf.vim not loaded" | echohl None
      return
   endif

   call fzf#run(fzf#wrap({
   \  'source': 'cd ' . shellescape($PALACE_DIR) . ' && find . -type f -not -path "./.git/*" | sed "s|^\./||"',
   \  'sink':   function('s:palace_link_sink'),
   \  'dir':    $PALACE_DIR,
   \  'options': ['--prompt', 'link > '],
   \  }))
endfunction

nnoremap <leader>nl :call PalaceLink()<CR>
