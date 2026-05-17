THIS_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR="$THIS_DIR/site"

if [ ! -d "$SITE_DIR" ]; then
    git clone git@github.com:myevan/myevan.github.io "$SITE_DIR"
fi

if [ ! -d "$SITE_DIR/.git" ]; then
    echo NOT_BOUND_SITE.GIT
    exit 1
fi

"$THIS_DIR/vmkdocs.sh" build

cd "$SITE_DIR" || exit 1
git add .
TIME=`date +"%y-%m-%d %H:%M:%S"`
HOST="$USER@`hostname`"
git commit -a -m "sync on $HOST at $TIME"
git push origin master
