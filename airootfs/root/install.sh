#!/bin/bash

INTERACTIVE=1

SCRIPTFILE=${0##*/}
PRINTERFILE="printer.sh"
PKGFILE="packages.sh"
ENVFILE="env.sh"
CONFFILE="config.sh"

source $PRINTERFILE
source $ENVFILE
source $PKGFILE

select_desktop_environment()
{
    # KDE vs GNOME vs i3 vs X11
    print_message "Selecting ${DESKTOP_ENV}..."

    if [[ $DESKTOP_ENV == "KDE" ]]
    then
        export PACKAGES="$PACKAGES $KDE"
    elif [[ $DESKTOP_ENV == "GNOME" ]]
    then
        export PACKAGES="$PACKAGES $GNOME"
    elif [[ $DESKTOP_ENV == "i3" ]]
    then
        export PACKAGES="$PACKAGES $I3"
    elif [[ $DESKTOP_ENV == "X11" ]]
    then
        export PACKAGES="$PACKAGES $X11"
    fi
}

select_bootloader()
{
    # rEFInd vs GRUB
    print_message "Selecting ${BOOTLOADER}..."

    if [[ $BOOTLOADER == "refind" ]]
    then
        export PACKAGES="$PACKAGES $REFIND"
    elif [[ $BOOTLOADER == "grub" ]]
    then
        export PACKAGES="$PACKAGES $GRUB"
    fi
}

select_video_drivers()
{
    # nVidia vs AMD vs VBox vs Intel
    print_message "Selecting ${XORG_DRIVERS} drivers..."

    if [[ $XORG_DRIVERS == "nvidia" ]]
    then
        export PACKAGES="$PACKAGES $NVIDIA"
    elif [[ $XORG_DRIVERS == "amd" ]]
    then
        export PACKAGES="$PACKAGES $AMD"
    elif [[ $XORG_DRIVERS == "vbox" ]]
    then
        export PACKAGES="$PACKAGES $VBOX"
    elif [[ $XORG_DRIVERS == "intel" ]]
    then
        export PACKAGES="$PACKAGES $INTEL"
    fi
}

install_packages()
{
    print_message "Installing packages..."
    pacstrap -C /root/pacman_on_iso.conf /mnt $PACKAGES --cachedir=/root/pkg --needed
}

generate_fstab()
{
    genfstab -p -U /mnt > /mnt/etc/fstab
}

copy_mirrorlist()
{
    cp mirrorlist /mnt/etc/pacman.d/mirrorlist -v
}

copy_scripts()
{
    cp $ENVFILE /mnt/root -v
    cp $CONFFILE /mnt/root -v
    cp $PRINTERFILE /mnt/root -v
    cp yay_install.sh /mnt/root -v
}

configure_system()
{
    print_warning ">>> Configuring your system with $DESKTOP_ENV, $BOOTLOADER and $XORG_DRIVERS... <<<"
    arch-chroot /mnt /bin/zsh -c "cd && ./$CONFFILE && rm $CONFFILE $ENVFILE -f"
}

prompt_environment()
{
    print_message "Your system will be installed using the data in '$ENVFILE'"
    print_warning "Make sure your data is correct in $ENVFILE before proceeding!"
    echo ""

    print_trailing "Do you want to install now? (y/N): "
    read ans

    case $ans in
        'y'|'Y')
            print_success "Installation started."
        ;;
        *)
            print_failure "Installation stopped."
            print_warning "Edit $ENVFILE and run this script again."
            exit 1
        ;;
    esac
}

check_mounted_drive() {
    MOUNTPOINT="/mnt"
    B=$(tput bold)
    N=$(tput sgr0)

    if [[ $(findmnt -M "$MOUNTPOINT") ]]; then
        print_success "Drive mounted in $MOUNTPOINT."
    else
        print_failure "Drive is NOT MOUNTED!"
        print_warning "Mount your drive in '$MOUNTPOINT' and re-run '$SCRIPTFILE' to install your system."
        exit 1
    fi
}

install_system()
{
    select_desktop_environment
    select_bootloader
    select_video_drivers

    install_packages
    generate_fstab

    copy_mirrorlist
    copy_scripts

    configure_system
}

verify_installation()
{
    [[ ! -f /mnt/root/$CONFFILE && ! -f /mnt/root/$ENVFILE && ! -f /mnt/root/$PRINTERFILE ]]
}

main()
{
    # Check pre-install state
    check_mounted_drive

    # Prompt user to check environment file before installing
    prompt_environment

    # Install and verify
    install_system
    verify_installation

    # Message at end
    if [[ $? == 0 ]]; then
        print_success "Installation finished! You can reboot now."
    else
        print_failure "Installation failed! Check errors before trying again."
        exit 1
    fi
}

# Execute main
main $@
