# 3×3 Median Filter on FPGA (Vivado)

An FPGA implementation project for a 3×3 median filter targeting the Digilent Nexys A7-100T. The current project demonstrates the filter datapath and its implementation results using an 8-bit grayscale, 64×64 simulation flow.

> **Project status:** the hardware setup currently demonstrates the FPGA implementation; it is not yet a true camera/display image-streaming system.

## Verified implementation results

Post-implementation timing meets the 100 MHz clock constraint:

| Metric | Result |
|---|---:|
| WNS | +7.054 ns |
| TNS | 0.000 ns |
| WHS | +0.059 ns |
| THS | 0.000 ns |
| WPWS | +3.750 ns |
| Failing endpoints | 0 |

The resulting critical-path estimate is approximately 339.4 MHz. This is calculated from `1 / (10 ns - 7.054 ns)` and is **not** a guaranteed operating frequency. See [results/implementation_results.md](results/implementation_results.md) for utilization and the full caveat.

## Current scope and limitations

- 8-bit grayscale pixels.
- 64×64 image simulation flow.
- A 3×3 window produces valid interior pixels only, so the expected output image is 62×62.
- No border reconstruction or padding is claimed in this package.
- The board constraints support switch-driven input and LED-driven output for implementation demonstration; they do not establish continuous image capture or display streaming.

## Repository layout

```text
src/          RTL source location (copy the project RTL here)
tb/           simulation testbench location
python/       64×64 grayscale image preparation, conversion, and comparison tools
constraints/  Nexys A7-100T pin/timing constraints
results/      verified post-implementation timing and utilization summary
images/       optional screenshots, waveform captures, and before/after images
```

## Add your current Vivado source files

The exact RTL and testbench were not provided with this package, so they are intentionally not recreated. Copy the sources from the working Vivado project into these exact locations before committing:

| Copy your file | Destination |
|---|---|
| `top1.v` | `src/top1.v` |
| `line_buffer.v` | `src/line_buffer.v` |
| `window_3x3.v` | `src/window_3x3.v` |
| `median9.v` | `src/median9.v` |
| `top1_TB.v` | `tb/top1_TB.v` |

The included `.gitkeep` placeholders only preserve the directories; replace them with the actual files. Add any additional RTL modules required by your design to `src/`.

## Image-flow utilities

Install Pillow, then run the scripts from the repository root:

```bash
python -m pip install -r python/requirements.txt
python python/jpg_to_png.py input.jpg work/input.png
python python/prepare_image.py work/input.png work/input_64x64.png
# Run your existing simulation and export its 62×62 pixel values.
python python/convert_back.py simulation_output.txt results/filter_output.png
python python/compare_images.py reference_62x62.png results/filter_output.png
```

`prepare_image.py` converts an image to grayscale and resizes it to 64×64. `convert_back.py` expects whitespace- or comma-separated integer pixel values (0–255) and writes a grayscale image; 62×62 is its default size. `compare_images.py` calculates MSE and PSNR only when the two images have identical dimensions.

## Vivado use

1. Create or open the Vivado project for the Nexys A7-100T device used in your existing project.
2. Add the copied RTL files and `tb/top1_TB.v`.
3. Add [constraints/nexys_a7_100t.xdc](constraints/nexys_a7_100t.xdc).
4. Confirm the top module and existing testbench configuration match your source.
5. Run simulation, synthesis, and implementation as usual.
