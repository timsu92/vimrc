autocmd InsertCharPre *.cpp,*.c,*.cc,*.h,*.hpp if v:char == ';' || v:char == ' ' || v:char == '+' || v:char == '-' || v:char == '*' || v:char == '/' | doautocmd User CocJumpPlaceholder | endif
