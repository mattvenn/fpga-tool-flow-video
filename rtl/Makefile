PROJ = simple
SEED = 12

ICEBREAKER_DEVICE = up5k
ICEBREAKER_PIN_DEF = icebreaker.pcf
ICEBREAKER_PACKAGE = sg48

TINYFPGA_DEVICE = lp8k
TINYFPGA_PIN_DEF = tinyfpga.pcf
TINYFPGA_PACKAGE = cm81

ICESTICK_DEVICE = hx1k
ICESTICK_PIN_DEF = icestick.pcf
ICESTICK_PACKAGE = tq144

HX8K_DEVICE = hx8k
HX8K_PACKAGE = ct256
HX8K_PIN_DEF = 8k.pcf

ALHAMBRA_DEVICE = hx1k
ALHAMBRA_PACKAGE = tq144
ALHAMBRA_PIN_DEF = alhambra.pcf

UP5K_DEVICE = up5k
UP5K_PIN_DEF = up5k.pcf
UP5K_PACKAGE = sg48

NEXTPNR_DIR = /home/matt/work/fpga/nextpnr

all: $(PROJ).rpt $(PROJ).bin

show: simple.v
	yosys -p 'read_verilog $<; proc; clean; show' #synth_ice40 -top top -json $@' $<

thinkpad-gui: simple.json
	MESA_GL_VERSION_OVERRIDE=3.2 MESA_GLSL_VERSION_OVERRIDE=150 nextpnr-ice40 --gui --seed $(SEED) --freq 30 --$(DEVICE) --asc $@ --pcf $(PIN_DEF) --json $(PROJ).json

gui:
	${NEXTPNR_DIR}/nextpnr-ice40 --gui --seed $(SEED) --freq 30 --$(DEVICE) --asc $@ --pcf $(PIN_DEF) --json $(PROJ).json --package sg48

%.json: %.v
	yosys -p 'synth_ice40 -top top -json $@' $<

%-icebreaker.asc: %.json
	${NEXTPNR_DIR}/nextpnr-ice40 --seed $(SEED) --freq 30 --package $(ICEBREAKER_PACKAGE) --$(ICEBREAKER_DEVICE) --asc $@ --pcf $(ICEBREAKER_PIN_DEF) --json $<

%-icestick.asc: %.json
	${NEXTPNR_DIR}/nextpnr-ice40 --seed $(SEED) --freq 30 --package $(ICESTICK_PACKAGE) --$(ICESTICK_DEVICE) --asc $@ --pcf $(ICESTICK_PIN_DEF) --json $<

%-tinyfpga.asc: %.json
	${NEXTPNR_DIR}/nextpnr-ice40 --seed $(SEED) --freq 30 --package $(TINYFPGA_PACKAGE) --$(TINYFPGA_DEVICE) --asc $@ --pcf $(TINYFPGA_PIN_DEF) --json $<

%-HX8K.asc: %.json
	${NEXTPNR_DIR}/nextpnr-ice40 --seed $(SEED) --freq 30 --package $(HX8K_PACKAGE) --$(HX8K_DEVICE) --asc $@ --pcf $(HX8K_PIN_DEF) --json $<

%-UP5K.asc: %.json
	${NEXTPNR_DIR}/nextpnr-ice40 --seed $(SEED) --freq 30 --package $(UP5K_PACKAGE) --$(UP5K_DEVICE) --asc $@ --pcf $(UP5K_PIN_DEF) --json $<

%-alhambra.asc: %.json
	${NEXTPNR_DIR}/nextpnr-ice40 --seed $(SEED) --freq 30 --package $(ALHAMBRA_PACKAGE) --$(ALHAMBRA_DEVICE) --asc $@ --pcf $(ALHAMBRA_PIN_DEF) --json $<

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

%_tb: %_tb.v %.v
	iverilog -o $@ $^

%_tb.vcd: %_tb
	vvp -N $< +vcd=$@

%_syn.v: %.blif
	yosys -p 'read_blif -wideports $^; write_verilog $@'

%_syntb: %_tb.v %_syn.v
	iverilog -o $@ $^ `yosys-config --datdir/ice40/cells_sim.v`

%_syntb.vcd: %_syntb
	vvp -N $< +vcd=$@

%-prog: %.bin
	iceprog $<

simple-tinyfpga-prog: simple-tinyfpga.bin
	tinyprog -p $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin

.SECONDARY:
.PHONY: all prog clean
