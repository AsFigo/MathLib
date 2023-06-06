all: mean fix ceil round abs rem mod floor log exp 

mean: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_mean.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_mean.log

exp: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_exp.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_exp.log

log: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_log.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_log.log

floor: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_floor.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_floor.log

fix: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_fix.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_fix.log

ceil: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_ceil.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_ceil.log

round: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_round.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_round.log

abs: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_abs.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_abs.log

rem: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_rem.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_rem.log

mod: clean
	vlib work
	vlog -mfcu -f flist ../tests/test_mod.sv -l mti_comp.log
	vsim -c top -do "run -all;exit" -l mti_mod.log

vlt: clean
	verilator --Mdir vw_work_dir --prefix Vtop --binary -Wno-INITIALDLY -Wno-lint --top-module top --assert -f flist -I../src 2>&1 | tee comp.log
	./vw_work_dir/Vtop +verilator+error+limit+10 2>&1 | tee run.log

clean:
	rm -fr work* vw_work_dir* obj* *.log
	
