#!/usr/bin/env bash
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

if [ -z "$DEV_ENV" ]; then
    echo "Env var DEV_ENV needs to be present."
    exit 1
fi
