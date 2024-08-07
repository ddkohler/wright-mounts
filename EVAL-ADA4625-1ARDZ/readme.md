# Wright Group charge amplifier

Mounting and interfacing for a low-cost, performant charge amplifier circuit.
The amplifier circuit is a modified evaluation board for the ADA4625.

## Files

* `adapter-plate.scad`: for mounting evaluation board to optical breadboard (1" grid, 1/4-20 bolts)
* `cover_plate.scad`: protective cover for the evaluation board, with through holes for banana plug clearance
* `mini-DIN-mount`: top plate for adapting banana plugs to the Wright Group standard DIN.  Note that this part is currently in development while we consider optimal connector solutions.


# Charge amplifier notes

The charge amplifier topology is identical to a transimpedance amplifier.
Namely, the feedback loop has a resistance, $R_f$ and capacitance, $C_f$, in parallel.
I believe the name difference just signifies two different objectives: a charge amplifier is designed to hold a charge for slow measurement and cares more about integrating the current source, $V \propto \int i(t) dt$, while a transimpedance amplifier is meant to keep fidelity to the original current transient, $V \propto i(t)$.
As a result of these differing objectives, the reactance value of the feedback loop can differ strongly between the two.

The capacitor dictates the gain from an current pulse.
For a burst of $q$ charge, the output signal will be $V_{out} = q/C_f$ for short times.
The voltage will decay exponentially with a time constant of $R_f C_f$.

## Example parameters

A PMT can easily have an gain of ~$10^6$, or $10^{-13}$ Farad per electron.  
For $C_f$=35 pF, the voltage spike from a single photon event will be ~5 mV.
With $R_f$ = 1 MOhm, the peak will persist for ~35 us.
Such parameters are suitable for kHz lasers with ~$\mu$s DAQ resolution.

Large feedback resistance will increase noise, so a balance may need to be found between the charge gain and the measurement time.  

# Parts list

* EVAL-ADA4625: evaluation board (comes pre-assembled in a voltage amplifier configuration)
* banana plugs (ground, V+, V-)
* Mini din panel mount socket
* various capacitors and resistors to modify the evaluation board (size 0805).


