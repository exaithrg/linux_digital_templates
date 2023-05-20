# NVBoard + IVerilog Makefile

# How to use NVboard to sim:
# USE: a n c
# mk OR mk all OR mk default # = mk d(default)
# mk nvboard # = mk n(nvboard), start NVBoard
# mk clean	 # = mk c(clean), clean files
# OR:
# mk nvall   # = mk f(fpga all flow), = mk n c

# How to use iverilog to sim:
# USE: f o r w c
# mk ivfgene # = mk l(file list), Generate ivfilesf
# mk ivogene # = mk o(.out file), Generate $(TBTOPNAME).out
# mk ivsim	 # = mk r(run simulation), Run $(TBTOPNAME).out
# mk gtkwave # = mk w(show wave), Run gtkwave
# mk clean	 # = mk c(clean), clean files
# OR:
# mk ivall   # = mk i(iverilog all flow), = mk l o r w

