" ___vital___
" NOTE: lines between '" ___vital___' is generated by :Vitalize.
" Do not mofidify the code nor insert new lines before '" ___vital___'
if v:version > 703 || v:version == 703 && has('patch1170')
  function! vital#_operator_aggressive#Unlocker#Holder#Value#import() abort
    return map({'is_makeable': '', 'make': ''},  'function("s:" . v:key)')
  endfunction
else
  function! s:_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze__SID$')
  endfunction
  execute join(['function! vital#_operator_aggressive#Unlocker#Holder#Value#import() abort', printf("return map({'is_makeable': '', 'make': ''}, \"function('<SNR>%s_' . v:key)\")", s:_SID()), 'endfunction'], "\n")
  delfunction s:_SID
endif
" ___vital___
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_copy_list(lhs, rhs)
	call filter(a:lhs, "0")
	for i in range(len(a:rhs))
		call add(a:lhs, a:rhs[i])
	endfor
endfunction


function! s:_copy_dict(lhs, rhs)
	call filter(a:lhs, "0")
	call extend(a:lhs, a:rhs)
endfunction


function! s:_copy(lhs, rhs)
	return type(a:lhs) == type({}) ? s:_copy_dict(a:lhs, a:rhs)
\		 : type(a:lhs) == type([]) ? s:_copy_list(a:lhs, a:rhs)
\		 : 0
endfunction


let s:obj = {}

function! s:obj.get()
	return self.__value
endfunction


function! s:obj.set(value)
	call s:_copy(self.__value, a:value)
	return self
endfunction


function! s:is_makeable(rhs)
	let type = type(a:rhs)
	return type == type({}) || type == type([])
endfunction


function! s:make(value)
	if !(type(a:value) == type([])
\	||   type(a:value) == type({}))
		throw "vital-unlocker Unlocker.Holder.Value.make() : No supported value type."
	endif
	let result = deepcopy(s:obj)
	let result.__value = a:value
	return result
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
