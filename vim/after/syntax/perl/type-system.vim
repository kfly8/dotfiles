" Perl highlighting for Signatures keywords

syntax match perlStatementProc "\<\%(method\|fun\)\>"
syntax match perlFunction +\<\%(method\|fun\)\>\_s*+ nextgroup=perlSubName
