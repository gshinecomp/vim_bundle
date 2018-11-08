#!/bin/bash

# diff -Naur ~/.vim/bundle/delview/plugin/delview.vim delview/plugin/delview.vim
patch ~/.vim/bundle/delview/plugin/delview.vim <<EOF
--- /home/erik/.vim/bundle/delview/plugin/delview.vim	2018-11-08 17:23:35.502501854 +0800
+++ delview/plugin/delview.vim	2018-11-08 16:24:15.477853706 +0800
@@ -1,6 +1,8 @@
 " #########################################################
 " # A way to delete 'mkview'
 function! MyDeleteView()
+	" add for vimrc function! MakeViewCheck() by erik
+	let g:Delview_executed = "executed"
 	let path = fnamemodify(bufname('%'),':p')
 	" vim's odd =~ escaping for /
 	let path = substitute(path, '=', '==', 'g')
@@ -14,6 +16,6 @@
 	call delete(path)
 	echo "Deleted: ".path
 endfunction
-command Delview call MyDeleteView()
+command! Delview call MyDeleteView()
 " Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
 cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>
EOF

# diff -Naur ~/.vim/bundle/taglist.vim/plugin/taglist.vim taglist.vim/plugin/taglist.vim
patch ~/.vim/bundle/taglist.vim/plugin/taglist.vim <<EOF
--- /home/erik/.vim/bundle/taglist.vim/plugin/taglist.vim	2013-02-26 19:47:16.000000000 +0800
+++ taglist.vim/plugin/taglist.vim	2018-11-08 15:56:23.541942019 +0800
@@ -536,6 +536,8 @@
 "verilog language
 let s:tlist_def_verilog_settings = 'verilog;m:module;c:constant;P:parameter;' .
             \ 'e:event;r:register;t:task;w:write;p:port;v:variable;f:function'
+let s:tlist_def_verilog_sv_settings = 'verilog;m:module;c:constant;P:parameter;' .
+            \ 'e:event;r:register;t:task;w:write;p:port;v:variable;f:function'
 
 " VHDL
 let s:tlist_def_vhdl_settings = 'vhdl;c:constant;t:type;T:subtype;r:record;e:entity;f:function;p:procedure;P:package'
EOF

# diff -Naur ~/.vim/bundle/mru.vim/plugin/mru.vim mru.vim/plugin/mru.vim
patch ~/.vim/bundle/mru.vim/plugin/mru.vim <<EOF
--- /home/erik/.vim/bundle/mru.vim/plugin/mru.vim	2018-11-08 17:23:27.670357421 +0800
+++ mru.vim/plugin/mru.vim	2018-11-08 15:54:26.757579790 +0800
@@ -235,7 +235,7 @@
 " MRU configuration variables {{{1
 " Maximum number of entries allowed in the MRU list
 if !exists('MRU_Max_Entries')
-    let MRU_Max_Entries = 100
+    let MRU_Max_Entries = 500
 endif
 
 " Files to exclude from the MRU list
EOF

## diff -aur ~/.vim/bundle/verilog_systemverilog.vim verilog_systemverilog.vim
#diff -aur /home/erik/.vim/bundle/verilog_systemverilog.vim/ftdetect/verilog_systemverilog.vim verilog_systemverilog.vim/ftdetect/verilog_systemverilog.vim
patch ~/.vim/bundle/verilog_systemverilog.vim/ftdetect/verilog_systemverilog.vim <<EOF
--- /home/erik/.vim/bundle/verilog_systemverilog.vim/ftdetect/verilog_systemverilog.vim	2018-10-17 16:47:23.827083799 +0800
+++ verilog_systemverilog.vim/ftdetect/verilog_systemverilog.vim	2018-11-08 16:14:45.881692846 +0800
@@ -1,4 +1,5 @@
 " Vim filetype plugin file
 " Language:	SystemVerilog (superset extension of Verilog)
 
-au! BufNewFile,BufRead *.v,*.vh,*.vp,*.sv,*.svi,*.svh,*.svp,*.sva setfiletype verilog_systemverilog
+" by erik: rename and change original verilog_systemverilog.vim and mark original file
+"au! BufNewFile,BufRead *.v,*.vh,*.vp,*.sv,*.svi,*.svh,*.svp,*.sva setfiletype verilog_systemverilog
EOF
#diff -aur /home/erik/.vim/bundle/verilog_systemverilog.vim/plugin/verilog_systemverilog.vim verilog_systemverilog.vim/plugin/verilog_systemverilog.vim
patch ~/.vim/bundle/verilog_systemverilog.vim/plugin/verilog_systemverilog.vim <<EOF
--- /home/erik/.vim/bundle/verilog_systemverilog.vim/plugin/verilog_systemverilog.vim	2018-11-08 13:34:23.415761820 +0800
+++ verilog_systemverilog.vim/plugin/verilog_systemverilog.vim	2018-11-08 16:41:34.816241129 +0800
@@ -27,7 +27,7 @@
 
 " Configure tagbar
 " This requires a recent version of universal-ctags
-let g:tagbar_type_verilog_systemverilog = {
+let g:tagbar_type_verilog_sv = {
     \ 'ctagstype'   : 'SystemVerilog',
     \ 'kinds'       : [
         \ 'b:blocks:1:1',
EOF

#只在 verilog_systemverilog.vim/ftdetect 存在：verilog_sv.vim
#只在 verilog_systemverilog.vim/ftplugin 存在：verilog_sv.vim
#只在 verilog_systemverilog.vim/indent 存在：verilog_sv.vim
#只在 verilog_systemverilog.vim/syntax 存在：systemverilog.vim
#只在 verilog_systemverilog.vim/syntax 存在：verilog_sv.vim
rsync -avPh ~/repos/vim_bundle/modified/verilog_systemverilog.vim/ftdetect/verilog_sv.vim ~/.vim/bundle/verilog_systemverilog.vim/ftdetect
rsync -avPh ~/repos/vim_bundle/modified/verilog_systemverilog.vim/ftplugin/verilog_sv.vim ~/.vim/bundle/verilog_systemverilog.vim/ftplugin
rsync -avPh ~/repos/vim_bundle/modified/verilog_systemverilog.vim/indent/verilog_sv.vim ~/.vim/bundle/verilog_systemverilog.vim/indent
rsync -avPh ~/repos/vim_bundle/modified/verilog_systemverilog.vim/syntax/verilog_sv.vim ~/.vim/bundle/verilog_systemverilog.vim/syntax
rsync -avPh ~/repos/vim_bundle/modified/verilog_systemverilog.vim/syntax/systemverilog.vim ~/.vim/bundle/verilog_systemverilog.vim/syntax

