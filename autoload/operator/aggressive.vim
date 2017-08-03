scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:V = aggressive#vital()
let s:Buffer = s:V.import("Coaster.Buffer")
let s:U = s:V.import("Unlocker.Rocker")
let s:Prelude = s:V.import("Data.String")
let s:Capture = s:V.import("Palette.Capture")


function! s:do(wise, func, config)
	let wise = s:Buffer.as_wise_key(a:wise)
	let text = s:Buffer.get_text_from_latest_yank(wise)
	let context = {
\		"text" : text,
\		"wise" : wise,
\		"config" : a:config,
\	}
	let result = a:func(context)

	if get(a:config, "replace", 1)
		call s:Buffer.paste_for_text(wise, getpos("'["), getpos("']"), result)
	endif
endfunction


function! operator#aggressive#do(wise)
	return s:do(a:wise, s:Func, s:config)
endfunction


let g:operator#aggressive#default_config = get(g:, "operator#aggressive#default_config", {
\	"replace" : 1
\})


function! operator#aggressive#func(func, ...)
	let s:Func = a:func
	let s:config = get(a:, 1, g:operator#aggressive#default_config)
	return "\<Plug>(operator-aggressive-expr-do-dummy)"
endfunction


function! operator#aggressive#execute(cmd, ...)
	return operator#aggressive#func({ context -> s:Capture.command(a:cmd, context) }, get(a:, 1, {}))
endfunction


function! operator#aggressive#expr(expr, ...)
	return operator#aggressive#execute("echon " . a:expr, get(a:, 1, {}))
endfunction


function! operator#aggressive#string(str, ...)
	return operator#aggressive#expr(string(str), get(a:, 1, {}))
endfunction


function! operator#aggressive#keymapping(str, ...)
	return operator#aggressive#expr(string(str), get(a:, 1, {}))
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
