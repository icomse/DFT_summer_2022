if exists("did_load_filetypes")
   finish
endif

au BufNewFile,BufRead *.pdb set filetype=pdb

augroup filetypedetect
   au! BufNewFile,BufRead *.inp setf cp2k
augroup END
