{ config, lib, ... }:

{
  systemd.services.mullvadVPN = {
    description = "Mullvad VPN Service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
      
       #!/usr/bin/env bash
readonly INTERVAL_SECONDS=300
readonly LOCATION_LIST=("dk" "fr" "fi" "de" "nl" "no" "se" "ch" "gb")

# Check if the user is logged in to their Mullvad account
check_login_status() {
    while true; do
        login_status=$(mullvad account get)
        if [[ $login_status == *"Not logged in on any account"* ]]; then
            echo "User is not logged in to their Mullvad account. Waiting to execute the script..."
            sleep 3
        elif [[ $login_status == *"Mullvad account:"* ]]; then
            echo "User is logged in to their Mullvad account. Proceeding with script execution."
            break
        else
            echo "Unexpected response from Mullvad. Exiting script."
            exit 1
        fi
    done
}

# Check if Mullvad VPN is in lockdown mode and set it to on if the user is logged in
check_lockdown_mode() {
    login_status=$(mullvad account get)
    if [[ $login_status == *"Mullvad account:"* ]]; then
        lockdown_status=$(mullvad lockdown-mode get)
        if [[ $lockdown_status == *"off"* ]]; then
            echo "Mullvad VPN is not in lockdown mode. Setting lockdown mode to on..."
            mullvad lockdown-mode set on
        else
            echo "Mullvad VPN is already in lockdown mode."
        fi
    else
        echo "User is not logged in to their Mullvad account. Waiting to set lockdown mode."
        check_login_status
        check_lockdown_mode
    fi
}

# Set the relay ownership to owned
mullvad relay set ownership owned

# Check if the user is logged in to their Mullvad account
check_login_status

# Set the tunnel protocol to WireGuard
mullvad relay set tunnel-protocol wireguard

# Check if Mullvad VPN is in lockdown mode and set it to on if the user is logged in
check_lockdown_mode

# Main loop to connect to a random location every minute
while true; do
    # Generate a random index to select a location
    random_index=$(( RANDOM % ${#LOCATION_LIST[@]} ))

    # Select a location based on the random index
    random_location=${LOCATION_LIST[$random_index]}

    # Connect to Mullvad VPN
    mullvad connect

    # Check if Mullvad VPN is in lockdown mode and set it to on if the user is logged in
    check_lockdown_mode

    # Set the relay to the randomly selected location
    echo "Connecting to $random_location..."
    mullvad relay set location $random_location
    echo "Connected to server in $random_location"

    sleep $INTERVAL_SECONDS
done
      '';
      Restart = "always";
      User = "user"; # Change this to the user who should run the service
      #Group = "your_group"; # Change this to the group who should run the service
    };
  };
}

