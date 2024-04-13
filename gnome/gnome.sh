#!/usr/bin/env bash

# set -e will terminate script immediately upon failure
set -e


pprint () {
    local cyan="\033[96m"
    local default="\033[39m"
    # ISO8601 timestamp + ms
    local timestamp
    timestamp=$(date +%FT%T.%3NZ)
    echo -e "${cyan}${timestamp} $1${default}" 1>&2
}

# Prompt to install Tor with a default value of 'N' and a timeout of 10 seconds
read -t 10 -p "> Do you want to anonymize the network traficc by using tor ? (Y/N) [N]: " -n 1 -r REPLY
echo # move to a new line

# If the user presses 'Y' or 'y', install Tor and set http_proxy
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    nix-env -iA nixos.tor
    export http_proxy=http://127.0.0.1:9050
    echo "Tor installed and http_proxy set."
# If the user presses 'N' or 'n', skip Tor installation
elif [[ "$REPLY" =~ ^[Nn]$ ]]; then
    echo "Tor installation skipped."
# If the user does not press any key within 10 seconds, proceed with the default action (install Tor)
else
    nix-env -iA nixos.tor
    export http_proxy=http://127.0.0.1:9050
    echo "Tor installed and http_proxy set (default action)."
fi


# Select DISK to format and install to
echo # move to a new line
pprint "> Select installation disk: "
select ENTRY in $(ls /dev/disk/by-id/);
do
    DISK="/dev/disk/by-id/$ENTRY"
    echo "Installing system on $ENTRY."
    break
done

# Continue with the rest of your setup script...

# Confirm wipe hdd
read -p "> Do you want to wipe all data on $ENTRY ?" -n 1 -r
echo # move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]
then
    # Clear disk (sometimes need to run wipefs twice when deleting partition)
    # May also need to `umount -R /mnt`
    pprint "Wiping $DISK. If errors occur, make sure all $DISK partitions are umounted and/or destroyed."
    pprint "To do so, run 'findmnt' to see all current mounts, umount /dev/sdX to unmount, and zpool export <poolname>." 
    wipefs -af "$DISK"
    sleep 1
    wipefs -af "$DISK"
    sgdisk -Zo "$DISK"
fi


pprint "Creating boot (EFI) partition ..."
parted -s $DISK mklabel gpt
parted -s -a optimal "$DISK" mkpart fat32 1MiB 1GiB 
parted $DISK set 1 esp on
parted $DISK set 1 boot on
parted $DISK -- mkpart NixOS 1GiB 100%
BOOT="$DISK-part1"

pprint "Formatting BOOT partition $BOOT as FAT32 ... "
mkfs.fat -n ESP -F32 "$BOOT"


pprint "Creating encrypted Btrfs partition ..."
cryptsetup luksFormat --type luks2 "$DISK-part2"
cryptsetup open "$DISK-part2" cryptroot --allow-discards
mkfs.btrfs -L root /dev/mapper/cryptroot

pprint "Mouting cryproot on /mnt"
mount /dev/mapper/cryptroot /mnt

pprint "Creating Btrfs subvolumes ..."
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/home


pprint "Inform kernel"
partprobe "$DISK"
sleep 1

pprint "umounting /mnt"
umount /mnt

pprint "Mounting Tmpfs and Btrfs subvolumes ..."
mount -t tmpfs -o size=2G,mode=755,noatime none /mnt
mkdir -p /mnt
mkdir -p /mnt/{nix,home,boot}
#mkdir -p /mnt/etc/secureboot/keys/{db,dbx,KEK,PK}
mkdir -p /mnt/home/user
mount -t tmpfs -o size=2G,mode=755,noatime,nosuid,noexec,nodev none /mnt/home/user
mount -o compress=zstd,subvol=nix /dev/mapper/cryptroot /mnt/nix

pprint "Mouting boot with umask=0077"
mount -t vfat -o umask=0077,defaults,noatime "$BOOT" /mnt/boot 

pprint "Generating NixOS configuration ..."
sudo nixos-generate-config --force --root /mnt

pprint "Setup Whonix Machine id ..."
HOSTID=$(head -c8 /etc/machine-id)
HARDWARE_CONFIG=$(mktemp)
cat <<CONFIG > "$HARDWARE_CONFIG"
  networking.hostId = "$HOSTID";
CONFIG
sed -i "\$e cat $HARDWARE_CONFIG" /mnt/etc/nixos/hardware-configuration.nix


pprint "moving .nix package into /mnt/etc/nixos/'."
sudo cp *.nix /mnt/etc/nixos/
sudo cp -r nixconf /mnt/etc/nixos/
sudo cp -r home /mnt/etc/nixos/
sudo mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nixconf

#pprint "Going into /mnt/etc directory.."
#cd /mnt/etc/ 

#pprint "Running sbctl create-keys..." 
#sudo sbctl create-keys 

pprint "nixos-install --root /mnt --flake /mnt/etc/nixos#user"
sudo nixos-install --root /mnt --flake /mnt/etc/nixos#user --impure



# http://libreddit.privacydev.net/r/Fedora/comments/r4a4so/interesting_fedora_does_not_support_hibernation/hmfc763/ why i don't use swap 
