THIS_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
"$THIS_DIR/venv.sh" pip "$@"
