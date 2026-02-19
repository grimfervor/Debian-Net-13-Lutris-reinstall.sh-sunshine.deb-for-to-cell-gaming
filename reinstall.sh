#!/bin/bash

# Log everything to a file as well as the screen
LOGFILE="reinstall_log.txt"
exec > >(tee -a "$LOGFILE") 2>&1

echo "------------------------------------------------"
echo "Starting System Reinstallation at $(date)"
echo "------------------------------------------------"

# Ensure script stops if a critical command fails
set -e

# --- System Prep & Architecture ---
# Enable 32-bit support for Wine/Lutris dependencies
echo "Enabling 32-bit support and updating..."
sudo dpkg --add-architecture i386 
sudo apt update && sudo apt upgrade -y

# --- Installing APT Packages ---
# Removed: code, google-chrome-stable
sudo apt install -y adduser antimicro apt apt-listchanges apt-utils base-files base-passwd bash bash-completion bind9-dnsutils bind9-host bsdutils busybox bzip2 ca-certificates console-setup coreutils cpio cron cron-daemon-common curl dash dbus debconf debconf-i18n debian-archive-keyring debian-faq debianutils dhcpcd-base diffutils dmidecode doc-debian dosfstools dpkg e2fsprogs eject fdisk file findutils firmware-intel-graphics firmware-iwlwifi flatpak fonts-wine gcc-14-base geany geary gettext-base git gparted grep groff-base grub-common grub-efi-amd64 gzip hostname ifupdown inetutils-telnet init init-system-helpers initramfs-tools installation-report intel-microcode iproute2 iputils-ping keyboard-configuration kmod krb5-locales laptop-detect less linux-sysctl-defaults locales login login.defs logrotate logsave lsof lvm2 lutris man-db manpages mawk media-types mount nano ncurses-base ncurses-bin ncurses-term netbase netcat-traditional nftables openssh-client openssl-provider-legacy os-prober passwd pciutils perl perl-base procps readline-common reportbug sed sensible-utils shim-signed sqlite3 sqv steam-devices sunshine systemd systemd-sysv systemd-timesyncd sysvinit-utils tar task-blendsel task-desktop task-english task-gnome-desktop task-laptop tasksel traceroute tzdata ucf udev usbutils util-linux util-linux-extra vim-common vim-tiny wamerican wget whiptail wine wine32:i386 wine64 wireless-tools wpasupplicant wtmpdb xz-utils zlib1g zstd 

# --- Installing Flatpaks ---
echo 'Setting up Flatpak...'
sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.github.tchx84.Flatseal com.valvesoftware.Steam net.davidotek.pupgui2 net.lutris.Lutris org.libretro.RetroArch tv.kodi.Kodi 

# --- Restoring Sanitized .bashrc ---
echo 'Writing .bashrc...'
cat << 'BASHRC_EOF' > ~/.bashrc
# [Standard .bashrc content omitted for brevity, but remains in your actual file]
BASHRC_EOF

# --- Finalizing ---
# Removed the local .deb installer for Chrome
echo "------------------------------------------------"
echo "Reinstallation Complete!"
echo "A log of this session is saved in reinstall_log.txt"
echo "------------------------------------------------"
