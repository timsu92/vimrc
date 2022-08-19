autocmd InsertCharPre *.cpp,*.c,*.cc,*.h,*.hpp if v:char == ';' | doautocmd User CocJumpPlaceholder | endif
