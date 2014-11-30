" space.vim "{{{1

" Last Update: Nov 30, Sun | 11:48:17 | 2014

" variables "{{{2

function s:VarDelSpaceCJK() "{{{3

    let s:PatCJKs = '[^\x00-\xff]'

    let s:PatCJKPuncWestern = '～\|！\|'

    let s:PatCJKPuncWestern .= '…\|—\|'

    let s:PatCJKPuncWestern .= '（\|）\|'
    let s:PatCJKPuncWestern .= '《\|》\|'

    let s:PatCJKPuncWestern .= '“\|”\|'
    let s:PatCJKPuncWestern .= '‘\|’\|'

    let s:PatCJKPuncWestern .= '；\|：\|'
    let s:PatCJKPuncWestern .= '，\|。\|'
    let s:PatCJKPuncWestern .= '？\|、\|'

    let s:PatCJKPuncWestern .= '·'

endfunction "}}}3

let s:Mark = '###LOOONG_PLACEHOLDER_FOR_SPACE###'

 "}}}2
" functions "{{{2

function space#DelSpaceTrail() "{{{3

    let l:pure = '\s\+$'
    let l:mixed = '\s*　\+$'

    if search(l:pure,'cw')

        execute '%s/' . l:pure . '//'

    endif

    if search(l:mixed,'cw')

        execute '%s/' . l:mixed . '//'

    endif

endfunction "}}}3

function space#DelSpaceCJK() "{{{3

    call <sid>VarDelSpaceCJK()

    let l:cjk =
    \ '\(' . s:PatCJKs . '\)' . ' \+' .
    \ '\(' . s:PatCJKs . '\)'

    if search(l:cjk,'cw')

        execute '%s/' . l:cjk . '/\1\2/g'

    endif

    let l:puncAfter =
    \ '\(\w\)' . ' \+' .
    \ '\(' . s:PatCJKPuncWestern . '\)'

    if search(l:puncAfter,'cw')

        execute '%s/' . l:puncAfter . '/\1\2/g'

    endif

    let l:puncBefore =
    \ '\(' . s:PatCJKPuncWestern . '\)' . ' \+' .
    \ '\(\w\)'

    if search(l:puncBefore,'cw')

        execute '%s/' . l:puncBefore . '/\1\2/g'

    endif

endfunction "}}}3

function space#DelLine(line) "{{{3

    if search(s:Mark,'cw')

        echo 'ERROR:' . " '" . s:Mark . "' found!"
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
