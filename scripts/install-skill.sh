#!/usr/bin/env bash

# Install the canonical skill folder into a supported agent's skill root.
# Run from a checked-out copy of this repository.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/../skills/mail-to-reminders"
SKILL_NAME="mail-to-reminders"

usage() {
  cat <<'EOF'
Usage: ./scripts/install-skill.sh <codex|claude>

Installs the mail-to-reminders skill without overwriting an existing skill.

Targets:
  codex   ~/.codex/skills
  claude  ~/.claude/skills
EOF
}

if [[ ! -f "${SOURCE_DIR}/SKILL.md" ]]; then
  echo "Could not find ${SOURCE_DIR}/SKILL.md." >&2
  exit 1
fi

if [[ $# -eq 1 ]]; then
  case "$1" in
    codex) DEST_ROOT="${HOME}/.codex/skills" ;;
    claude) DEST_ROOT="${HOME}/.claude/skills" ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
elif [[ $# -eq 2 && "$1" == "--dest" ]]; then
  DEST_ROOT="$2"
else
  usage >&2
  exit 2
fi

DESTINATION="${DEST_ROOT}/${SKILL_NAME}"
if [[ -e "${DESTINATION}" ]]; then
  echo "Refusing to overwrite existing skill: ${DESTINATION}" >&2
  exit 3
fi

mkdir -p "${DEST_ROOT}"
cp -R "${SOURCE_DIR}" "${DESTINATION}"
echo "Installed ${SKILL_NAME} to ${DESTINATION}"
