" Perl highlighting for Signatures keywords

syntax match perlStatementProc "\<\%(func\|method\|fun\)\>"
syntax match perlFunction +\<\%(func\|method\|fun\)\>\_s*+ nextgroup=perlSubName

syntax match perlStatementProc "\<\%(let\|static\|const\)\>"

syntax match perlStatementProc +\<\%(let\|static\|const\)\>\_s*+ nextgroup=perlType

