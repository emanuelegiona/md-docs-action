# MIT License

# Copyright (c) 2025 Emanuele Giona

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#!/bin/bash

# No preparation needed, exit right away
if [[ -z "$INPUT_PREPARE_SCRIPT" ]]; then
    exit 0
fi

# Exit with error if 'prepare-script' filename is not found in the repository root
if [[ ! -f "$1/$INPUT_PREPARE_SCRIPT" ]]; then
    echo "Error: file '${INPUT_PREPARE_SCRIPT}' not found (check 'prepare-script' input value)"
    exit 1
fi

# Execute the 'prepare-script' providing documentation root directory and any additional arguments (user-provided)
OUTCOME=1

chmod +x "${1}/${INPUT_PREPARE_SCRIPT}"
if [[ -z "$INPUT_PREPARE_ARGS" ]]; then
    . "${1}/${INPUT_PREPARE_SCRIPT}" "${1}/manual" && OUTCOME=0
else
    . "${1}/${INPUT_PREPARE_SCRIPT}" "${1}/manual" "${INPUT_PREPARE_ARGS}" && OUTCOME=0
fi

exit $OUTCOME
