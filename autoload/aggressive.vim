scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#of("operator_aggressive")
" let s:V = vital#of("vital")

function! aggressive#vital()
	return s:V
endfunction


function! aggressive#do(expr, context)
	
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
