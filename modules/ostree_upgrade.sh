ostree_upgrade_menu(){
    echo "================================================"
    echo "1. Wipe layers/overrides 2. Upgrade"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
            sudo rpm-ostree reset
            sudo sytemctl reboot
            ;;

        2)
            sudo ostree admin pin 0
            sudo  rpm-ostree rebase fedora:fedora/39/x86_64/kinoite
            sudo systemctl reboot
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        launch_menu
        ;;
    esac
    unset input
}