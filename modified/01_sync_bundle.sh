#!/bin/bash

# modified: delview.vim
#           add let g:Delview_executed = "executed"
# modified: taglist.vim
#           add s:tlist_def_verilog_sv_settings
# modified: mru.vim
#           fix let MRU_Max_Entries = 500

# modified: verilog_systemverilog.vim
#           cp ftdetect/verilog_systemverilog.vim ftdetect/verilog_sv.vim ; and mark old verilog_systemverilog.vim
#           cp ftplugin/verilog_systemverilog.vim ftplugin/verilog_sv.vim
#
#           use https://github.com/nachumk/systemverilog.vim/blob/master/indent/systemverilog.vim (1.7), rename to indent/verilog_sv.vim
#             fix indent/verilog_sv.vim, mark by erik, mark (){} for indent
#
#           modified plugin/verilog_systemverilog.vim
#             rename let g:tagbar_type_verilog_systemverilog to let g:tagbar_type_verilog_sv
#
#           cp syntax/verilog_systemverilog.vim syntax/verilog_sv.vim
#             1. modified syntax/verilog_sv.vim
#                a. mark verilogOperator and verilogGlobal for 'syn match' and 'HiLink'
#                b. change let b:current_syntax = "verilog_systemverilog" to let b:current_syntax = "verilog_sv"
#             2. ref https://github.com/nachumk/systemverilog.vim/blob/master/syntax/systemverilog.vim (1.7)
#                copy 'syn match' for sv* from systemverilog.vim
#                  svInvPre~svDefine, svInvSystemFunction~svDelimiter
#                add new sv* 'HiLink'

rsync -avPh ~/.vim/bundle/ ~/repos/vim_bundle --exclude=.git/ --exclude=tags
rsync -avPh ~/.vimrc ~/repos/vim_bundle

###################################################################
## mismatch to old system
## older version NERO_tree 4.2.0
## URL: https://github.com/scrooloose/nerdtree/tree/4.2.0
#rsync -avPh ~/.vim/bundle/nerdtree-4.2.0/ ~/repos/vim_bundle/nerdtree
#
## older version 1.1, newest version 2.2
## URL: https://www.vim.org/scripts/script.php?script_id=311
#rsync -avPh ~/.vim/bundle/grep-1.1/ ~/repos/vim_bundle/grep
#
## newest version 4.6, git is older 4.5
## URL: https://www.vim.org/scripts/script.php?script_id=273
#rsync -avPh ~/.vim/bundle/taglist_46.vim/ ~/repos/vim_bundle/taglist.vim
#
