set -e

THIS_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
VENV_DIR="$THIS_DIR/.venv"
REQ_FILE="$THIS_DIR/requirements.txt"
STAMP_FILE="$VENV_DIR/.requirements.stamp"
cmd="$1"
shift

ensure_dependencies() {
    need_sync=0
    if [ -f "$REQ_FILE" ]; then
        if [ ! -e "$STAMP_FILE" ] || [ "$REQ_FILE" -nt "$STAMP_FILE" ]; then
            need_sync=1
        fi
        if [ ! -x "$VENV_DIR/bin/$cmd" ]; then
            need_sync=1
        fi
    fi

    if [ "$need_sync" -eq 1 ]; then
        if command -v uv >/dev/null 2>&1; then
            uv pip sync --python "$VENV_DIR/bin/python" "$REQ_FILE"
        else
            "$VENV_DIR/bin/pip" install -r "$REQ_FILE"
        fi
        touch "$STAMP_FILE"
    fi
}

if [ ! -d "$VENV_DIR" ]; then
    if command -v uv >/dev/null 2>&1; then
        uv venv "$VENV_DIR"
    else
        python -m venv "$VENV_DIR"
    fi
fi

ensure_dependencies

exec "$VENV_DIR/bin/$cmd" "$@"
