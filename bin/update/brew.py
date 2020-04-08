#!/usr/bin/env python3

import os
import subprocess
import sys

def main():
    parent = os.path.dirname(os.path.realpath(__file__))
    brewfile = os.path.realpath(f"{parent}/../../Brewfile")
    subprocess.run([
        "brew",
        "bundle",
        "dump",
        "--force",
        "--no-lock",
        "--file",
        brewfile
    ], check=True)
    print(f"Successfully wrote to {brewfile}")
    subprocess.run(["git", "diff", brewfile], check=True)

if __name__ == '__main__':
    sys.exit(main())
