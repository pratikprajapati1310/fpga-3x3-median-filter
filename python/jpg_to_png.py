"""Convert a JPEG image to PNG for the median-filter preparation flow."""
from argparse import ArgumentParser
from pathlib import Path

from PIL import Image


def main() -> None:
    parser = ArgumentParser(description="Convert a JPEG image to PNG.")
    parser.add_argument("input", type=Path, help="Input JPEG image")
    parser.add_argument("output", type=Path, help="Output PNG image")
    args = parser.parse_args()

    args.output.parent.mkdir(parents=True, exist_ok=True)
    with Image.open(args.input) as image:
        image.save(args.output, format="PNG")
    print(f"Wrote {args.output}")


if __name__ == "__main__":
    main()
