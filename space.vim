" space.vim "{{{1

" Last Update: Oct 17, Fri | 22:31:58 | 2014

" variables "{{{2

if !exists('g:Loaded_Space')
	let g:Loaded_Space = 0
endif
if g:Loaded_Space > 0
	finish
endif
let g:Loaded_Space = 1

let s:Mark = '###LOOONG_PLACEHOLDER_FOR_SPACE###'

 "}}}2
" functions "{{{2

function space#DelSpace_Trail() "{{{3

	let l:pattern = '\s*　\+$'

	%s/\s*$//e

	while search(l:pattern,'cw')
		execute '%s/' . l:pattern . '//'
	endwhile

endfunction "}}}3

function space#DelSpace_Inner() "{{{3

	let l:pattern = '[^\x00-\xff]'

	execute '%s/\(' . l:pattern . '\) \+\(' .
	\ l:pattern . '\)/\1\2/ge'

endfunction "}}}3

function space#DelLine(line) "{{{3

	if search(s:Mark,'cw')
		echo "ERROR: '" . s:Mark . "' found!"
		return
	endif

	" additional lines
	if a:line == 0 && search('^$','cw')
		execute '1,$-1g/^$/+1s/^$/' . s:Mark .
		\ '/e'
		execute '$s/^$/' . s:Mark . '/e'
		if search(s:Mark,'cw')
			execute 'g/^'. s:Mark . '$/delete'
		endif

	" empty lines
	elseif a:line == 1 && search('^$','cw')
		g/^$/delete

	endif

endfunction "}}}3

 "}}}2
" vim: set fdm=marker fdl=20 tw=50: "}}}1
