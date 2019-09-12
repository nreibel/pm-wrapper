#!/bin/bash

function usage()
{
    echo "usage: $0 [search|install|update|remove] <package>"
    echo "       $0 [update-all]"
}

case "$1" in
    search)
        case `basename $0` in
            apt-pm)
                apt-cache search  $2
                ;;
            pip-pm)
                pip search $2
                ;;
            snap-pm)
                snap search $2
                ;;
            *)
                echo "Unsupported package manager"
                usage
                ;;
        esac
        ;;
    install)
        case `basename $0` in
            apt-pm)
                apt-get install $2
                ;;
            pip-pm)
                pip install $2
                ;;
            snap-pm)
                snap install $2
                ;;
            *)
                echo "Unsupported package manager"
                usage
                ;;
        esac
        ;;
    update)
        case `basename $0` in
            apt-pm)
                apt-get update && apt-get upgrade $2
                ;;
            pip-pm)
                pip install --upgrade $2
                ;;
            snap-pm)
                snap refresh $2
                ;;
            *)
                echo "Unsupported package manager"
                usage
                ;;
        esac
        ;;
    remove)
        case `basename $0` in
            apt-pm)
                apt-get remove $2
                ;;
            pip-pm)
                pip uninstall $2
                ;;
            snap-pm)
                snap remove $2
                ;;
            *)
                echo "Unsupported package manager"
                usage
                ;;
        esac
        ;;
    full-update)
        case `basename $0` in
            apt-pm)
                apt-get update && apt-get -y dist-upgrade
                ;;
            pip-pm)
                for pkg in `pip list --outdated | tail -n +3 | awk '{print $1}'`
                do
                    pip install --upgrade $pkg
                done
                ;;
            snap-pm)
                snap refresh
                ;;
            *)
                echo "Unsupported package manager"
                usage
                ;;
        esac
        ;;
    *)
        echo "Unsupported operation"
        usage
        ;;
esac
    
