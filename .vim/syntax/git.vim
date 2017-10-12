" Vim syntax to add support to git log --graph and git log --stat
" Author: Chris Ruvolo https://github.com/cruvolo

source $VIMRUNTIME/syntax/git.vim

":runtime! syntax/git.vim
"unlet b:current_syntax

"syn include @mainGit $VIMRUNTIME/syntax/git.vim

syn match gitGraph /^\%([|* \\\/]\+\)\s\+\(\x\{4,40}\)\s\+\(.*\)$/ contains=gitHashAbbrev,gitLogSummary
"synt match gitLogSummary /\s\+\(.*\)$/ contained

syn match gitStat /| \%(\d\+\) \%(+*\)\%(-*\)$/ contains=gitStatPlus contains=gitStatMinus
syn match gitStatPlus /+*/ contained nextgroup=gitStatMinus skipwhite display
syn match gitStatMinus /-*/ contained skipwhite display

hi def link gitStatPlus diffAdded
hi def link gitStatMinus diffRemoved

