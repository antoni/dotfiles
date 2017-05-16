# layout split

define bwrite
    save breakpoints ~/.gdb_breakpoints
end

define bread
   source ~/.gdb_breakpoints
end
# source ~/peda/peda.py
