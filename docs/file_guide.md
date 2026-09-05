# File-by-file guide

| Path | Purpose |
|---|---|
| `README.md` | Project overview, verified claims, setup, limitations, and publish checklist. |
| `.gitignore` | Keeps Vivado build products, temporary simulation files, and local outputs out of Git. |
| `constraints/nexys_a7_100t.xdc` | Verified Nexys A7-100T pin mappings and 100 MHz timing constraint. Port names must match the copied top-level RTL. |
| `src/.gitkeep` | Holds the source directory in Git until actual RTL is copied in. Replace by adding `top1.v`, `line_buffer.v`, `window_3x3.v`, and `median9.v`. |
| `tb/.gitkeep` | Holds the testbench directory. Add the existing `top1_TB.v` here. |
| `python/jpg_to_png.py` | Converts a JPEG to PNG, retaining image content for the next preparation step. |
| `python/prepare_image.py` | Converts an image to 8-bit grayscale and resizes it to 64×64 for the current simulation flow. |
| `python/convert_back.py` | Converts simulator-exported integer pixels into a grayscale output image; defaults to 62×62. |
| `python/compare_images.py` | Compares equal-sized grayscale images using MSE and PSNR. |
| `python/requirements.txt` | Python package requirement for the included image utilities. |
| `results/implementation_results.md` | Verified post-implementation timing and resource summary, including the limited Fmax estimate. |
| `images/.gitkeep` | Reserved for user-supplied screenshots, waveforms, and before/after images. |

## Before first commit

1. Copy the five existing Verilog files to the locations described in `README.md`.
2. Check that top-level port names match the XDC: `clk`, `rst`, `valid_in`, `pixel_in[7:0]`, `pixel_out[7:0]`, and `valid_out`.
3. Add project evidence such as the implementation timing/utilization report screenshots and simulation waveform if you want them public.
4. Run the scripts on your own image/output files and retain only useful, reproducible example assets.
5. Read the README once more and avoid claiming live camera or display streaming unless it has actually been implemented.
