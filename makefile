MODS = \
	abs.v \
	count_pulse.v \
	dest_selector.v \
	dff.v \
	diffdev.v \
	insert_counter.v \
	oneshot.v \
	tb.v \
	vendor.v

tb: $(MODS)
	iverilog -o tb $(MODS)
