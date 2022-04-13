if exists('g:beacon_loaded') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

lua require('beacon').setup()
let g:beacon_loaded = 1

let &cpo = s:save_cpo
unlet s:save_cpo
