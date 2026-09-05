# Post-implementation results

These are the verified results recorded for the current implementation, constrained with a 10.000 ns (100 MHz) clock.

## Timing summary

| Metric | Value | Interpretation |
|---|---:|---|
| WNS | +7.054 ns | Setup timing met |
| TNS | 0.000 ns | No total negative setup slack |
| WHS | +0.059 ns | Hold timing met |
| THS | 0.000 ns | No total negative hold slack |
| WPWS | +3.750 ns | Pulse-width timing met |
| Failing endpoints | 0 | No reported timing failures |

All recorded timing constraints were met.

### Derived Fmax estimate

Using the 10 ns constraint and reported WNS:

`critical-path estimate = 10.000 ns - 7.054 ns = 2.946 ns`

`estimated Fmax = 1 / 2.946 ns ≈ 339.4 MHz`

This is a derived, post-implementation critical-path estimate only. It should be described as an **approximate estimated Fmax**, not as a guaranteed operating frequency or a separately verified clock target. The verified result is that the existing 100 MHz constraint passed.

## Utilization summary

| Resource | Used | Available | Utilization |
|---|---:|---:|---:|
| Slice LUTs | 389 | 63,400 | 0.61% |
| Slice registers | 146 | 126,800 | 0.12% |
| Slices | 133 | 15,850 | 0.84% |
| Block RAM tiles | 0 | 135 | 0% |
| DSPs | 0 | 240 | 0% |
| IOBs | 20 | 210 | 9.52% |
| BUFGCTRL | 1 | 32 | 3.13% |

The recorded implementation uses no dedicated BRAM or DSP resources. This is a factual utilization observation; it does not by itself establish how the memory architecture will scale to larger images.
