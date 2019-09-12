#!/bin/bash 

SCRIPT_NAME='pm-wrap.sh'
INSTALL_DIR='/usr/local/bin/'

# Check root
if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

function install()
{
    cp "./files/$SCRIPT_NAME" "$INSTALL_DIR"
    ln -s `realpath "$INSTALL_DIR/$SCRIPT_NAME"` "$INSTALL_DIR/apt-pm" 2>/dev/null
    ln -s `realpath "$INSTALL_DIR/$SCRIPT_NAME"` "$INSTALL_DIR/pip-pm" 2>/dev/null
    ln -s `realpath "$INSTALL_DIR/$SCRIPT_NAME"` "$INSTALL_DIR/snap-pm" 2>/dev/null
}

function remove()
{
    rm "$INSTALL_DIR/$SCRIPT_NAME" "$INSTALL_DIR/apt-pm" "$INSTALL_DIR/pip-pm" "$INSTALL_DIR/snap-pm"
}

case $1 in
    remove)
        remove
        echo "Uninstalled"
        ;;
    install)
        ;&
    *)
        install
        echo "Installed"
        ;;
esac
