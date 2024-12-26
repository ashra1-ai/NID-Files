#!/bin/bash

# Configuration
REMOTE_HOST="example.sensor.local"
REMOTE_USER="root"
REMOTE_PASSWORD="${{ secrets.SURICATA_SECRET_SSH_MGT_PASSWORD }}"
LOCAL_RULES_DIR="./rules"
REMOTE_RULES_FILE="/etc/suricata/local.rules"

# Function to check if sshpass is installed
check_sshpass() {
  command -v sshpass &> /dev/null || { echo "sshpass is not installed. Please install it first."; exit 1; }
}

# Function to check if the password environment variable is set
check_password() {
  [ -z "$REMOTE_PASSWORD" ] && { echo "REMOTE_PASSWORD environment variable is not set."; exit 1; }
}

# Function to push rules to remote sensor and restart Suricata
push_rules_and_restart() {
  # Combine all rule files into a single file
  cat "$LOCAL_RULES_DIR"/*.rules > combined_rules.tmp || { echo "Failed to combine rule files."; exit 1; }

  # Use sshpass to copy the combined rules file to the remote sensor
  sshpass -p "$REMOTE_PASSWORD" scp combined_rules.tmp "$REMOTE_USER@$REMOTE_HOST:$REMOTE_RULES_FILE" || { echo "Failed to push rules to $REMOTE_HOST."; exit 1; }

  echo "Rules successfully pushed to $REMOTE_HOST:$REMOTE_RULES_FILE"

  # Restart Suricata service on the remote sensor
  sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$REMOTE_HOST" 'systemctl restart suricata' || { echo "Failed to restart Suricata service on $REMOTE_HOST."; exit 1; }

  echo "Suricata service restarted successfully on $REMOTE_HOST"

  # Clean up the temporary file
  rm combined_rules.tmp || { echo "Failed to remove temporary file."; exit 1; }
}

# Main execution
check_sshpass
check_password
push_rules_and_restart

echo "Script completed successfully."