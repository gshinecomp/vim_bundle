" Vim filetype plugin file
" Language:	SystemVerilog (superset extension of Verilog)

" by erik: rename and change original verilog_systemverilog.vim and mark original file
au! BufNewFile,BufRead *.v,*.vh,*.vp,*.sv,*.svi,*.svh,*.svp,*.sva setfiletype verilog_sv
