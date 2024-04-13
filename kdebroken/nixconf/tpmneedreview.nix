3. Full Disk Encryption with TPM2

For full disk encryption using TPM2, you can follow these steps:

    Ensure boot.initrd.systemd.enable is set to true in your configuration.nix.

    Add tpm2-tss to environment.systemPackages.

    Rebuild your system configuration.

    Run systemd-cryptenroll with the appropriate options for your encrypted device:

systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/<your encrypted device>

This command enrolls the encrypted device with TPM2, allowing for automatic unlocking 3.
Additional Considerations

    TPM2 Tools: Ensure you have the tpm2-tools package installed for managing TPM2 devices.
    User Permissions: Make sure the user account you're using has the necessary permissions to access TPM2 devices and manage keys.

    1. Add the User to the tss Group

You can add a user to the tss group by modifying your configuration.nix file. Here's an example of how to add a user named yourusername to the tss group:

{ config, pkgs, ... }:

{
 users.users.yourusername = {
    isNormalUser = true;
    extraGroups = [ "tss" ]; # Add the user to the tss group
 };
}
