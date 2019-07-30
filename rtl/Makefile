PROJ = simple

PIN_DEF = icebreaker.pcf
DEVICE = up5k

all: $(PROJ).rpt $(PROJ).bin

%.json: %.v
	yosys -p 'synth_ice40 -top top -json $@' $<

%.asc: $(PIN_DEF) %.json
	nextpnr-ice40 --seed $(SEED) --freq 30 --up5k --asc marlann.asc --pcf $(PIN_DEF) --json example.json

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

prog: $(PROJ).bin
	iceprog $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin

.SECONDARY:
.PHONY: all prog clean
