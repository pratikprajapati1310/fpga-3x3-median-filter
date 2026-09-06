# FPGA 3×3 Median Filter

Verilog implementation of a 3×3 median filter for 8-bit grayscale image processing, developed in Vivado and targeting the Digilent Nexys A7-100T FPGA.

## Highlights

- 3×3 median-filter datapath implemented in Verilog
- 8-bit grayscale pixel processing
- 64×64 image simulation flow
- Target device: Nexys A7-100T (`xc7a100tcsg324-1`)
- 100 MHz timing constraint met after implementation
- 389 LUTs (0.61%) and 146 registers (0.12%) used
- Zero reported timing violations and failing endpoints

## Implementation Results

The design was implemented with a 10.000 ns clock constraint (100 MHz).

| Metric | Result |
|---|---:|
| Worst Negative Slack (WNS) | +7.054 ns |
| Total Negative Slack (TNS) | 0.000 ns |
| Worst Hold Slack (WHS) | +0.059 ns |
| Total Hold Slack (THS) | 0.000 ns |
| Worst Pulse Width Slack (WPWS) | +3.750 ns |
| Failing endpoints | 0 |

The 100 MHz timing constraint is met. A critical-path-based frequency estimate is approximately 339.4 MHz; this is an estimate derived from the reported slack, not a guaranteed operating frequency.

Detailed timing and resource-utilization results are available in [results/implementation_results.md](results/implementation_results.md).

## Project Scope

- 8-bit grayscale pixel processing
- 64×64 input-image simulation flow
- Valid 3×3 median-filter output for interior pixels, producing a 62×62 output image
- No border padding or border reconstruction
- Switch inputs and LED outputs for board-level demonstration
- Live camera capture and display streaming are outside the current scope

## Repository Structure

```text
├── src/          Verilog RTL modules
├── tb/           Simulation testbenches
├── constraints/  Nexys A7-100T XDC constraints
├── python/       Image preparation and comparison utilities
├── results/      Timing and utilization results
├── images/       Optional project images
└── docs/         Additional documentation
```

## RTL Modules

The `src/` directory contains the design modules:

- `top1.v` — top-level design module
- `line_buffer.v` — image line-buffer logic
- `window_3x3.v` — 3×3 pixel-window generation
- `median9.v` — median calculation for nine pixels
- `cmp2.v` — comparison logic
- `top.v` — additional project source module

## Simulation

The `tb/` directory contains testbenches for the complete design and individual modules:

- `top1_TB.v`
- `median9_TB.v`
- `cmp2_TB.v`
- `TB_top.v`

For complete-design simulation, use `top1` as the design top module and `top1_TB` as the simulation top module.

## Image Utilities

Install the required Python package:

```bash
python -m pip install -r python/requirements.txt
```

Prepare a 64×64 grayscale input image:

```bash
python python/jpg_to_png.py input.jpg work/input.png
python python/prepare_image.py work/input.png work/input_64x64.png
```

Convert simulator-exported pixel values to a 62×62 output image:

```bash
python python/convert_back.py simulation_output.txt results/filter_output.png
```

Compare two equal-sized grayscale images:

```bash
python python/compare_images.py reference_62x62.png results/filter_output.png
```

`compare_images.py` calculates Mean Squared Error (MSE) and Peak Signal-to-Noise Ratio (PSNR).

## Building in Vivado

1. Create a Vivado project targeting `xc7a100tcsg324-1`.
2. Add the Verilog files in `src/` as Design Sources.
3. Add the required files in `tb/` as Simulation Sources.
4. Add [constraints/nexys_a7_100t.xdc](constraints/nexys_a7_100t.xdc).
5. Set `top1` as the design top module.
6. Set the required testbench as the simulation top module.
7. Run behavioral simulation, synthesis, and implementation.

## Board Interface

The XDC file defines a 100 MHz clock and this demonstration interface:

- `pixel_in[7:0]`: Nexys A7 switches `SW0`–`SW7`
- `pixel_out[7:0]`: Nexys A7 LEDs `LED0`–`LED7`
- `rst` and `valid_in`: input controls
- `valid_out`: output-valid indication

See [constraints/nexys_a7_100t.xdc](constraints/nexys_a7_100t.xdc) for exact pin assignments.
