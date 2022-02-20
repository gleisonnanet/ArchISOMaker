#!/bin/bash

script_path=$(readlink -f ${0%/*})
source "${script_path}/airootfs/root/packages.sh"

# Custom variables
work_dir="work"
out_dir="out"
temp_mnt="${script_path}/TEMPMNT"
custom_pkg_dir="${script_path}/airootfs/root/pkg"
UPDATECACHE=1


compilecalamares() {
#   mkdir customrepo
#   mkdir customrepo/x86_64
#   mkdir customrepo/i686
#   cd customrepo
  echo "Preparing Calamares-build..."
#   curl http://archmaker.guidedlinux.org/PKGBUILD > customrepo/archmaker-calamares/PKGBUILD
#   git clone https://github.com/calamares/calamares.git 
#   FILES="calamaresslides/*"
#   currentslide=1
#   for f in $FILES
#   do
#   currentline=$(( $currentslide + 27 ))
#   sed -i "${currentline}a\ \ \ \ cp $(pwd)\/$f src\/branding\/custombranding\/" ./customrepo/archmaker-calamares/PKGBUILD
#   echo "    echo '    ' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '    Slide {' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '        ' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '        Image {' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '            id: background${currentslide}' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '            source: \"${f##*/}\"' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '            width: 800; height: 440' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '            fillMode: Image.PreserveAspectFit' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '            anchors.centerIn: parent' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '        }' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '    }' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   currentslide=$(( $currentslide + 1 ))
#   done
#   sed -i "s/DISTRNAME/'mydistro'/g" ./customrepo/archmaker-calamares/PKGBUILD
#   sed -i "s/DISTRVERSION/${distroversion}/g" ./customrepo/archmaker-calamares/PKGBUILD
#   echo "    echo '    ' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   echo "    echo '}' >> src/branding/custombranding/show.qml" >> slideshowchanges
#   lastline=$(( $currentslide + 27 ))
#   sed -i '/mkdir -p build/r slideshowchanges' ./customrepo/archmaker-calamares/PKGBUILD
#   rm slideshowchanges
#   cd ./customrepo/archmaker-calamares
#   makepkg --printsrcinfo > .SRCINFO
#   cd ../
#   echo "Building qt5-styleplugins-git..."
#   git clone https://aur.archlinux.org/qt5-styleplugins-git.git
#   cd qt5-styleplugins-git
#   makepkg -si
#   cp *.pkg.ta* ../x86_64
#   cd ../
#   echo "Building calamares..."
#   cd archmaker-calamares
#   makepkg -s
#   cp *.pkg.ta* ../x86_64
#   cd ../
#   rm -rf qt5-styleplugins-git archmaker-calamares
#   cd ../
#   echo "archmaker-calamares" | sudo tee --append ./workingdir/packages.both > /dev/null
}
compileaurpkgs() {
    echo "compile"
#   mkdir customrepo/custompkgs
#   repopath="$(readlink -f .)"
#   buildingpath="$(readlink -f ./customrepo/custompkgs)"
#   while IFS='' read -r currentpkg || [[ -n "$currentpkg" ]]; do
#     cd customrepo/custompkgs
#     curl $currentpkg > ./currentpkg.tar.gz
#     tar xf currentpkg.tar.gz
#     rm currentpkg.tar.gz
#     for d in */ ; do
#       cd "$d"
#     done
#     makepkg -s
#     cp *.pkg.ta* ../../x86_64
#     cd $buildingpath
#     for d in */ ; do
#       rm -rf "$d"
#     done
#     cd $repopath
#   done < "aurpackages"
#   rm -rf customrepo/custompkgs
#   unset repopath buildingpath
}

kde(){
    pacman -Sy  alsa-utils amd-ucode arch-install-scripts archinstall b43-fwcutter base bind-tools brltty broadcom-wl btrfs-progs clonezilla cloud-init crda cryptsetup darkhttpd ddrescue dhclient dhcpcd diffutils dmraid dnsmasq dosfstools e2fsprogs edk2-shell efibootmgr espeakup ethtool exfatprogs f2fs-tools fatresize fsarchiver gnu-netcat gpart gpm gptfdisk grml-zsh-config hdparm intel-ucode ipw2100-fw ipw2200-fw irssi iw iwd jfsutils kitty-terminfo less lftp libfido2 libusb-compat linux linux-atm linux-firmware livecd-sounds lsscsi lvm2 lynx man-db man-pages mc mdadm memtest86+ mkinitcpio mkinitcpio-archiso mkinitcpio-nfs-utils modemmanager mtools nano nbd ndisc6 nfs-utils nilfs-utils nmap ntfs-3g nvme-cli openconnect openssh openvpn partclone parted partimage pcsclite ppp pptpclient pv qemu-guest-agent reflector reiserfsprogs rp-pppoe rsync rxvt-unicode-terminfo screen sdparm sg3_utils smartmontools sof-firmware squashfs-tools sudo syslinux systemd-resolvconf tcpdump terminus-font testdisk tmux tpm2-tss udftools usb_modeswitch usbmuxd usbutils vim virtualbox-guest-utils-nox vpnc wireless-regdb wireless_tools wpa_supplicant wvdial xfsprogs xl2tpd zsh xorg xorg-xinit xorg-drivers xterm dmenu feh gparted mesa-demos arch-install-scripts b43-fwcutter broadcom-wl btrfs-progs clonezilla crda darkhttpd ddrescue dhclient dialog dmraid dnsmasq dnsutils dosfstools elinks ethtool exfat-utils f2fs-tools fsarchiver gnu-netcat gpm gptfdisk grml-zsh-config grub hdparm ipw2100-fw ipw2200-fw irssi lftp linux-atm lsscsi mc mtools ndisc6 nfs-utils nilfs-utils nmap ntfs-3g ntp openconnect openssh openvpn partclone parted partimage ppp pptpclient rp-pppoe rsync sdparm sg3_utils smartmontools sudo tcpdump testdisk usb_modeswitch vim-minimal vpnc wget wireless_tools wvdial xl2tpd base-devel bash-completion xdg-user-dirs-gtk xorg-server xorg-xinit xorg-twm xterm xorg-drivers plasma sddm plasma  kde-application

}


# Helper function to run make_*() only one time per architecture.
run_once() {
    if [[ ! -e ${work_dir}/build.${1} ]]; then
        $1
        touch ${work_dir}/build.${1}
    fi
}

# Create needed folders for make_local_repo
make_folder() {
    echo "Creating temporal root folder..."

    # Make root directory
    if [[ ! -e ${temp_mnt} ]]; then
        mkdir -p ${temp_mnt}
        echo "Creating temporal install root at ${temp_mnt}"
        mkdir -m 0755 -p "${temp_mnt}"/var/{cache/pacman/pkg,lib/pacman,log} ${temp_mnt}/{dev,run,etc}
        mkdir -m 1777 -p "${temp_mnt}"/tmp
        mkdir -m 0555 -p "${temp_mnt}"/{sys,proc}
    fi

    # Make repo folder
    if [[ ! -e ${custom_pkg_dir} ]]; then
        mkdir -p ${custom_pkg_dir}
    fi
}

# Pull packages from Internet
# See packages.sh
make_download() {
    echo "Downloading packages..."

    pacman -Syw --root ${temp_mnt} --cachedir ${custom_pkg_dir} --noconfirm $ALL


    echo "compiling calamares packages..."
    compilecalamares
    echo "Installing calamares packages..."
    compileaurpkgs

}

# Create Pacman DB
make_database() {
    echo "Creating package database..."

    n=0

    # If the command didn't run correctly, re-run. It solves the file-not-found error. Go figure.
    # We'll re-run the command up to 5 times.
    until [ $n -ge 5 ]
    do
        repo-add -R -n ${custom_pkg_dir}/custom.db.tar.gz ${custom_pkg_dir}/*pkg.tar.{xz,zst} && break  # If command ran ok, don't re-run
        n=$[$n+1]
        sleep 1
    done
}

# Make local pkg database and repo only if needed
make_local_repo() {
    echo "Creating local repo..."

    run_once make_folder

    if (( UPDATECACHE )); then
        run_once make_download
        run_once make_database
    fi
    sync

    echo ""
    echo "Local repo is ready!"
}

# Cleaning duties
wrap_up() {
    echo "Wrapping up..."

    OWNER=${SUDO_USER:-$USER}

    rm ${work_dir} -rf
    rm ${temp_mnt} -rf
    chown $OWNER ${out_dir}/*.iso -v
    mv ${out_dir}/* .. -v
}
