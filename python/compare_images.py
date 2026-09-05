"""Calculate MSE and PSNR between two equal-sized grayscale images."""
from argparse import ArgumentParser
from math import inf, log10
from pathlib import Path

from PIL import Image


def main() -> None:
    parser = ArgumentParser(description="Compare two images using MSE and PSNR.")
    parser.add_argument("reference", type=Path, help="Reference image")
    parser.add_argument("candidate", type=Path, help="Image to evaluate")
    args = parser.parse_args()

    with Image.open(args.reference) as ref, Image.open(args.candidate) as candidate:
        reference = ref.convert("L")
        evaluated = candidate.convert("L")
        if reference.size != evaluated.size:
            raise ValueError(f"Image dimensions differ: {reference.size} vs {evaluated.size}.")
        ref_pixels = list(reference.getdata())
        candidate_pixels = list(evaluated.getdata())

    mse = sum((a - b) ** 2 for a, b in zip(ref_pixels, candidate_pixels)) / len(ref_pixels)
    psnr = inf if mse == 0 else 10 * log10((255**2) / mse)
    print(f"Dimensions: {reference.size[0]}x{reference.size[1]}")
    print(f"MSE: {mse:.6f}")
    print("PSNR: inf dB" if psnr == inf else f"PSNR: {psnr:.6f} dB")


if __name__ == "__main__":
    main()
