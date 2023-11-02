#!/bin/bash
echo "$(date): Starting procedure..."
WORKDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
export WORKDIR

update_os () {
    echo "Updating system..."; sleep 2
    export DEBIAN_FRONTEND=noninteractive
    if apt-get update; then
        if apt-get upgrade -y; then
            apt-get autoremove -y
            echo -e "Update Completed\n"
        fi
    fi
}

main () {
    if ! update_os; then
       echo "Error during system update."
       exit 1
    fi

    read -r -p 'Is "/opt/games/" existent and contains content? (yes/no): ' CHOICE
    case "${CHOICE}" in
        yes)
            bash "live-build/main.sh"
        ;;
        no)
            echo "Aborting..."
            exit 100
        ;;
        *)
            echo 'Aborting... Please type "yes" or "no".'
            exit 100
        ;;
    esac
}

# Check for root privs.
if [ "$USER" != "root" ]; then
    echo "You need to be root."
    exit 1
fi

main 2>&1 | tee -a debug.log