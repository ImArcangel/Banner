#-------------------------------------------------------------------------------
# Makefile for EC1723-Lab 3.
# Author: Angel Terrones <aterrones@usb.ve>
#-------------------------------------------------------------------------------
.FOUT=out
.PYTHON=python3
.PYTEST=pytest

.RTL=$(shell cd rtl; pwd)
.TEST=$(shell cd test; pwd)
.TOPE_V=banner

# ********************************************************************
.PHONY: default clean distclean

# ********************************************************************
# Syntax check
# ********************************************************************
check-verilog:
	@verilator --lint-only -Wall -y $(.RTL) $(.RTL)/$(.TOPE_V).v && echo "CHECK: OK"

# ********************************************************************
# Test
# ********************************************************************
test-banner: check-verilog
	@mkdir -p $(.FOUT)
	@ln -sf $(.TEST)/tb_banner.v $(.FOUT)/.
	@ln -sf $(.RTL)/* $(.FOUT)/.
	@$(.PYTEST) --tb=short test/test_$(.TOPE_V)_cosim.py

# ********************************************************************
# Clean
# ********************************************************************
clean:
	@rm -rf $(.FOUT)/
	@find . | grep -E "(\.vcd)" | xargs rm -rf

distclean: clean
	@find . | grep -E "(__pycache__|\.pyc|\.pyo|\.vcd|\.cache)" | xargs rm -rf
