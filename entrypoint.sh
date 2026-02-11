#!/bin/bash
set -euo pipefail

. /workdir/ncs/zephyr/zephyr-env.sh
/bin/bash /workdir/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -t arm-zephyr-eabi
/bin/bash /workdir/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -c

build_dir="${INPUT_BUILD_DIR:-build}"
board="${INPUT_BOARD:?INPUT_BOARD is required}"
add_flags="${INPUT_ADD_FLAGS:---no-sysbuild}"

# Split add_flags into args so users can pass CMake options after --
read -r -a add_flags_args <<< "${add_flags}"

exec west build --build-dir "${build_dir}" . --pristine --board "${board}" "${add_flags_args[@]}"
