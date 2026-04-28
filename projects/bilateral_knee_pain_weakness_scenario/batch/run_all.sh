#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
LOG_DIR="${ROOT_DIR}/logs"
GEN_DIR="${ROOT_DIR}/generated"

mkdir -p "${LOG_DIR}"

python3 "${ROOT_DIR}/scripts/generate_scenarios.py"

# TODO: Replace with actual SCONE CLI command in your environment.
# Examples (to be verified):
#   sconecmd --scenario <file.scone>
#   scone --headless <file.scone>
SCONE_CMD="${SCONE_CMD:-TODO_SET_SCONE_CMD}"

if [[ "${SCONE_CMD}" == "TODO_SET_SCONE_CMD" ]]; then
  echo "[TODO] SCONE_CMD is not set. Export SCONE_CMD with a valid executable." >&2
  echo "[TODO] Example: export SCONE_CMD=/opt/scone/bin/sconecmd" >&2
  exit 1
fi

for scenario_file in "${GEN_DIR}"/*.scone; do
  [[ -e "${scenario_file}" ]] || continue
  base="$(basename "${scenario_file}" .scone)"
  log_file="${LOG_DIR}/${base}.log"
  echo "[RUN] ${base}"
  "${SCONE_CMD}" "${scenario_file}" >"${log_file}" 2>&1
  echo "[DONE] ${base} -> ${log_file}"
done
