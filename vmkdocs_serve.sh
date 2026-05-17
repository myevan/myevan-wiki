THIS_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
"$THIS_DIR/vmkdocs.sh" serve -a 0.0.0.0:8000 "$@"
