"""Create the current project's 64x64, 8-bit grayscale simulation input."""
from argparse import ArgumentParser
from pathlib import Path

from PIL import Image


def main() -> None:
    parser = ArgumentParser(description="Convert an image to 64x64 grayscale PNG.")
    parser.add_argument("input", type=Path, help="Input image")
    parser.add_argument("output", type=Path, help="Output 64x64 grayscale PNG")
    args = parser.parse_args()

    args.output.parent.mkdir(parents=True, exist_ok=True)
    with Image.open(args.input) as image:
        prepared = image.convert("L").resize((64, 64), Image.Resampling.LANCZOS)
        prepared.save(args.output, format="PNG")
    print(f"Wrote {args.output} (64x64, 8-bit grayscale)")


if __name__ == "__main__":
    main()
