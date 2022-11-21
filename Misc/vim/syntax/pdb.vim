" Vim syntax file for pdb (Protein Data Bank format)
"
" Author: mumeiyamibito (http://www3.to/mumeiyamibito)
" Modified By: Liang-Bo Wang (liang-bo.wang@wustl.edu)
" Last Change: 2015/11/07
"
" The syntax (column) was referred from http://bit.ly/1RC9GtI
"
" Reference:
" https://mumeiyamibito.blogspot.jp/2015/11/protein-data-bank-vim-syntax.html

if exists("b:current_syntax")
  finish
endif

" ===== ATOM,HETATM =====
" ***** define *****
syn match R_ATOM     /^ATOM../                 nextgroup=Serial
syn match R_HETATM   /^HETATM/                 nextgroup=Serial
syn match Serial     /\%>6v.*\%12v/  contained nextgroup=AtomName skipwhite
syn match AtomName   /\%>12v.*\%17v/ contained nextgroup=AltLoc
syn match AltLoc     /\%>16v.*\%18v/ contained nextgroup=ResName
syn match ResName    /\%>17v.*\%21v/ contained nextgroup=ChainID skipwhite
syn match ChainID    /\%>21v.*\%23v/ contained nextgroup=ResSeq
syn match ResSeq     /\%>22v.*\%27v/ contained nextgroup=iCode
syn match iCode      /\%>26v.*\%28v/ contained nextgroup=CoordX skipwhite
syn match CoordX     /\%>30v.*\%39v/ contained nextgroup=CoordY
syn match CoordY     /\%>38v.*\%47v/ contained nextgroup=CoordZ
syn match CoordZ     /\%>46v.*\%55v/ contained nextgroup=Occupancy skipwhite
syn match Occupancy  /\%>54v.*\%61v/ contained nextgroup=TempFactor skipwhite
syn match TempFactor /\%>60v.*\%67v/ contained nextgroup=Element skipwhite
syn match Element    /\%>76v.*\%79v/ contained nextgroup=Charge
syn match Charge     /\%>78v.*\%81v/ contained


" ***** Color *****
hi R_ATOM     ctermfg=lightred guifg=lightred
hi def link   R_HETATM R_ATOM
hi Serial     ctermfg=red         guifg=red
hi AtomName   ctermfg=yellow      guifg=yellow
hi AltLoc     ctermfg=white       guifg=white
hi ResName    ctermfg=blue        guifg=blue
hi ChainID    ctermfg=darkblue    guifg=darkblue
hi ResSeq     ctermfg=cyan        guifg=cyan
hi iCode      ctermfg=white       guifg=white
hi CoordX     ctermfg=lightgreen  guifg=lightgreen
hi CoordY     ctermfg=green       guifg=green
hi CoordZ     ctermfg=darkgreen   guifg=darkgreen
hi Occupancy  ctermfg=magenta     guifg=magenta
hi TempFactor ctermfg=darkmagenta guifg=darkmagenta
hi Element    ctermfg=yellow      guifg=yellow
hi Charge     ctermfg=green       guifg=green


" ===== CONECT =====
" ***** define *****
syn match R_CONECT   /^CONECT/                 nextgroup=Connect_s
syn match Connect_s  /\%>6v.*\%12v/  contained nextgroup=Connect_1
syn match Connect_1  /\%>11v.*\%17v/ contained nextgroup=Connect_2
syn match Connect_2  /\%>16v.*\%22v/ contained nextgroup=Connect_3
syn match Connect_3  /\%>21v.*\%27v/ contained nextgroup=Connect_4
syn match Connect_4  /\%>26v.*\%32v/ contained nextgroup=Connect_e
syn match Connect_e  /\%>31v\s*\S\+\s*$/ contained

" ***** color *****
hi R_CONECT   ctermfg=lightgreen guifg=lightgreen
hi Connect_s  ctermfg=red        guifg=red
hi Connect_1  ctermfg=yellow     guifg=yellow
hi Connect_2  ctermfg=green      guifg=green
hi Connect_3  ctermfg=cyan       guifg=cyan
hi Connect_4  ctermfg=blue       guifg=blue
hi Connect_e  ctermfg=white      guifg=white ctermbg=red guibg=red


" ===== Others =====
" ***** define *****
syn match R_END    /^END.*$/
syn match R_MODEL  /^MODEL.*$/
syn match R_ENDMDL /^ENDMDL.*$/
syn match R_TER    /^TER.*$/

syn match R_HEADER /^HEADER.*$/
syn match R_TITLE  /^TITLE.*$/
syn match R_SOURCE /^SOURCE.*$/
syn match R_CAVEAT /^CAVEAT.*$/
syn match R_COMPND /^COMPND.*$/
syn match R_KEYWDS /^KEYWDS.*$/
syn match R_NUMMDL /^NUMMDL.*$/
syn match R_EXPDTA /^EXPDTA.*$/
syn match R_AUTHOR /^AUTHOR.*$/
syn match R_REVDAT /^REVDAT.*$/
syn match R_JRNL   /^JRNL.*$/
syn match R_REMARK /^REMARK.*$/
syn match R_DBREF  /^DBREF.*$/
syn match R_SEQRES /^SEQRES.*$/
syn match R_MODRES /^MODRES.*$/
syn match R_HET    /^HET\s\s\s.*$/
syn match R_HETNAM /^HETNAM.*$/
syn match R_FORMUL /^FORMUL.*$/
syn match R_LINK   /^LINK.*$/
syn match R_SITE   /^SITE.*$/
syn match R_CRYST  /^CRYST.*$/
syn match R_ORIGX  /^ORIGX.*$/
syn match R_SCALE  /^SCALE.*$/
syn match R_MASTER /^MASTER.*$/

" ***** color *****
hi R_TER ctermfg=black guifg=black ctermbg=yellow guibg=yellow
hi def link R_MODEL  R_TER
hi def link R_ENDMDL R_TER
hi R_END ctermfg=white guifg=white ctermbg=darkblue guibg=darkblue
hi R_Other ctermfg=darkgray guifg=darkgray
hi def link R_HEADER R_Other
hi def link R_TITLE  R_Other
hi def link R_SOURCE R_Other
hi def link R_CAVEAT R_Other
hi def link R_COMPND R_Other
hi def link R_KEYWDS R_Other
hi def link R_NUMMDL R_Other
hi def link R_EXPDTA R_Other
hi def link R_AUTHOR R_Other
hi def link R_REVDAT R_Other
hi def link R_JRNL   R_Other
hi def link R_REMARK R_Other
hi def link R_DBREF  R_Other
hi def link R_SEQRES R_Other
hi def link R_MODRES R_Other
hi def link R_HET    R_Other
hi def link R_HETNAM R_Other
hi def link R_FORMUL R_Other
hi def link R_LINK   R_Other
hi def link R_SITE   R_Other
hi def link R_CRYST  R_Other
hi def link R_ORIGX  R_Other
hi def link R_SCALE  R_Other
hi def link R_MASTER R_Other

let b:current_syntax = "pdb"

