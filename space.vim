" space.vim "{{{1

" Last Update: Oct 27, Mon | 21:15:10 | 2014

" variables "{{{2

function s:Var_DelSpace_CJK() "{{{3

	let s:Pat_CJK_CJK = '[^\x00-\xff]'

	let s:Pat_CJKPunc_Western = '～\|！\|'
	let s:Pat_CJKPunc_Western .= '…\|—\|'
	let s:Pat_CJKPunc_Western .= '（\|）\|'
	let s:Pat_CJKPunc_Western .= '；\|：\|'
	let s:Pat_CJKPunc_Western .= '“\|”\|'
	let s:Pat_CJKPunc_Western .= '‘\|’\|'
	let s:Pat_CJKPunc_Western .= '《\|》\|'
	let s:Pat_CJKPunc_Western .= '，\|。\|'
	let s:Pat_CJKPunc_Western .= '？\|、\|'
	let s:Pat_CJKPunc_Western .= '·'

endfunction "}}}3

let s:Mark = '###LOOONG_PLACEHOLDER_FOR_SPACE###'

 "}}}2
" functions "{{{2

function space#DelSpace_Trail() "{{{3

	let l:pure = '\s\+$'
	let l:mixed = '\s*　\+$'

	if search(l:pure,'cw')
		execute '%s/' . l:pure . '//'
	endif

	if search(l:mixed,'cw')
		execute '%s/' . l:mixed . '//'
	endif

endfunction "}}}3

function space#DelSpace_CJK() "{{{3

	call <sid>Var_DelSpace_CJK()

	execute '%s/\(' . s:Pat_CJK_CJK . '\) \+\(' .
	\ s:Pat_CJK_CJK . '\)/\1\2/ge'

	execute '%s/\(\w\) \+\(' .
	\ s:Pat_CJKPunc_Western . '\)/\1\2/ge'

	execute '%s/\(' . s:Pat_CJKPunc_Western .
	\ '\) \+\(\w\)/\1\2/ge'

endfunction "}}}3

function space#DelLine(line) "{{{3

	if search(s:Mark,'cw')
		echo "ERROR: '" . s:Mark . "' found!"
		return 1
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
