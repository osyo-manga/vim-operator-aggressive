scriptencoding utf-8
if exists('g:loaded_operator_aggressive')
  finish
endif
let g:loaded_operator_aggressive = 1

let s:save_cpo = &cpo
set cpo&vim


call operator#user#define('aggressive-expr-do-dummy', 'operator#aggressive#do')
call operator#user#define('aggressive-replace-expr-do-dummy', 'operator#aggressive#replace#do')


let &cpo = s:save_cpo
unlet s:save_cpo
