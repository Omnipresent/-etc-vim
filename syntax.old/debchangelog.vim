" Vim syntax file
" Language:    Debian changelog files
" Maintainer:  Debian Vim Maintainers <pkg-vim-maintainers@lists.alioth.debian.org>
" Former Maintainers: Gerfried Fuchs <alfie@ist.org>
"                     Wichert Akkerman <wakkerma@debian.org>
" Last Change: 2010 Oct 21
" URL: http://hg.debian.org/hg/pkg-vim/vim/raw-file/unstable/runtime/syntax/debchangelog.vim

" Standard syntax initialization
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Case doesn't matter for us
syn case ignore

" Define some common expressions we can use later on
syn match debchangelogName	contained "^[[:alnum:]][[:alnum:].+-]\+ "
syn match debchangelogUrgency	contained "; urgency=\(low\|medium\|high\|critical\|emergency\)\( \S.*\)\="
syn match debchangelogTarget	contained "\v %(frozen|unstable|%(testing|%(old)=stable)%(-proposed-updates|-security)=|experimental|%(lenny|squeeze)-%(backports%(-sloppy)=|volatile)|%(dapper|hardy|jaunty|karmic|lucid|maverick|natty|oneiric)%(-%(security|proposed|updates|backports|commercial|partner))=)+"
syn match debchangelogVersion	contained "(.\{-})"
syn match debchangelogCloses	contained "closes:\_s*\(bug\)\=#\=\_s\=\d\+\(,\_s*\(bug\)\=#\=\_s\=\d\+\)*"
syn match debchangelogLP	contained "\clp:\s\+#\d\+\(,\s*#\d\+\)*"
syn match debchangelogEmail	contained "[_=[:alnum:].+-]\+@[[:alnum:]./\-]\+"
syn match debchangelogEmail	contained "<.\{-}>"

" Define the entries that make up the changelog
syn region debchangelogHeader start="^[^ ]" end="$" contains=debchangelogName,debchangelogUrgency,debchangelogTarget,debchangelogVersion oneline
syn region debchangelogFooter start="^ [^ ]" end="$" contains=debchangelogEmail oneline
syn region debchangelogEntry start="^  " end="$" contains=debchangelogCloses,debchangelogLP oneline

" Associate our matches and regions with pretty colours
if version >= 508 || !exists("did_debchangelog_syn_inits")
  if version < 508
    let did_debchangelog_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink debchangelogHeader		Error
  HiLink debchangelogFooter		Identifier
  HiLink debchangelogEntry		Normal
  HiLink debchangelogCloses		Statement
  HiLink debchangelogLP			Statement
  HiLink debchangelogUrgency		Identifier
  HiLink debchangelogName		Comment
  HiLink debchangelogVersion		Identifier
  HiLink debchangelogTarget		Identifier
  HiLink debchangelogEmail		Special

  delcommand HiLink
endif

let b:current_syntax = "debchangelog"

" vim: ts=8 sw=2
