"""Convert text-exported 8-bit simulator pixels into a grayscale PNG."""
from argparse import ArgumentParser
from pathlib import Path
import re

from PIL import Image


def read_pixels(path: Path) -> list[int]:
    values = [int(token) for token in re.findall(r"[-+]?\d+", path.read_text(encoding="utf-8"))]
    if any(value < 0 or value > 255 for value in values):
        raise ValueError("Pixel values must be integers from 0 through 255.")
    return values


def main() -> None:
    parser = ArgumentParser(description="Convert exported pixel values to grayscale PNG.")
    parser.add_argument("input", type=Path, help="Text file containing decimal pixel values")
    parser.add_argument("output", type=Path, help="Output PNG image")
    parser.add_argument("--width", type=int, default=62, help="Output width (default: 62)")
    parser.add_argument("--height", type=int, default=62, help="Output height (default: 62)")
    args = parser.parse_args()

    if args.width <= 0 or args.height <= 0:
        raise ValueError("Width and height must be positive.")
    pixels = read_pixels(args.input)
    expected = args.width * args.height
    if len(pixels) != expected:
        raise ValueError(f"Expected {expected} pixels for {args.width}x{args.height}, found {len(pixels)}.")

    args.output.parent.mkdir(parents=True, exist_ok=True)
    image = Image.new("L", (args.width, args.height))
    image.putdata(pixels)
    image.save(args.output, format="PNG")
    print(f"Wrote {args.output} ({args.width}x{args.height}, 8-bit grayscale)")


if __name__ == "__main__":
    main()
