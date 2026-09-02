#!/usr/bin/env bash
# Install study-guide-builder as a Claude Code / agent skill, without the
# plugin system -- for a single project, a non-Claude-Code agent, or a copy
# you intend to edit locally. Most users want the plugin install instead:
#   /plugin marketplace add AndyMDH/study-guide-builder
#   /plugin install study-guide-builder
#
# Usage:
#   ./install.sh                 # symlink into ~/.claude/skills/study-guide-builder (global)
#                                # and the /study-guide command into ~/.claude/commands
#   ./install.sh --project       # symlink into ./.claude/skills/study-guide-builder (current project only)
#   ./install.sh --copy          # copy instead of symlink (won't track future `git pull` updates)
#   ./install.sh --project --copy

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/skills/study-guide-builder"

TARGET_ROOT="$HOME/.claude/skills"
MODE="symlink"

for arg in "$@"; do
  case "$arg" in
    --project) TARGET_ROOT="$(pwd)/.claude/skills" ;;
    --copy) MODE="copy" ;;
    *)
      echo "Unknown argument: $arg" >&2
      echo "Usage: $0 [--project] [--copy]" >&2
      exit 1
      ;;
  esac
done

DEST="$TARGET_ROOT/study-guide-builder"
mkdir -p "$TARGET_ROOT"

if [ -e "$DEST" ] || [ -L "$DEST" ]; then
  echo "Error: $DEST already exists. Remove it first if you want to reinstall." >&2
  exit 1
fi

CMD_SRC="$REPO_DIR/commands/study-guide.md"
CMD_ROOT="$(dirname "$TARGET_ROOT")/commands"
CMD_DEST="$CMD_ROOT/study-guide.md"
mkdir -p "$CMD_ROOT"

if [ "$MODE" = "symlink" ]; then
  ln -s "$SRC" "$DEST"
  echo "Symlinked $DEST -> $SRC"
  if [ ! -e "$CMD_DEST" ] && [ ! -L "$CMD_DEST" ]; then
    ln -s "$CMD_SRC" "$CMD_DEST"
    echo "Symlinked $CMD_DEST -> $CMD_SRC  (/study-guide command)"
  fi
  echo "Future 'git pull' in $REPO_DIR will update the installed skill automatically."
else
  cp -R "$SRC" "$DEST"
  echo "Copied $SRC -> $DEST"
  if [ ! -e "$CMD_DEST" ]; then
    cp "$CMD_SRC" "$CMD_DEST"
    echo "Copied $CMD_SRC -> $CMD_DEST  (/study-guide command)"
  fi
  echo "This copy will NOT update on 'git pull' -- rerun install.sh --copy to refresh it."
fi

echo
echo "Optional, not required to use the skill:"
echo "  - an Exa API key (EXA_API_KEY) for the strongest grounding — the skill"
echo "    falls back to WebSearch and will ask before doing so"
echo "  - the 'simple-english' skill installed alongside this one — study-guide-builder"
echo "    loads it for its sentence-level writing rules"
