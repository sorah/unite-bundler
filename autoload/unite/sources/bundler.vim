let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
 \  'name': 'bundler',
 \  'default_action': { '*': 'lcd' },
 \  'default_kind': 'directory'
 \ }


if exists('g:unite_bundler_command')
  let s:bundler_command = g:unite_bundler_command
else
  let s:bundler_command = "bundle"
endif

function! unite#sources#bundler#define()
  return s:unite_source
endfunction

function! s:unite_source.gather_candidates(args, context)
  return map(
    \   split(unite#util#system(s:bundler_command. ' show --paths'), "\n"),
    \   '{
    \     "word": substitute(v:val, ".\\+/", "", ""),
    \     "action__directory": fnamemodify(v:val, ":p:h"),
    \     "action__path": v:val
    \   }'
    \ )
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
