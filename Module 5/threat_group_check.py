#!/usr/bin/env python3
import json
import sys


def load_ttp_database(file_path):
    """Loads the TTP database from a JSON file.

    Args:
        file_path (str): Path to the JSON file containing TTP indicators.

    Returns:
        dict: Dictionary containing loaded TTP data.
    """

    with open(file_path, 'r') as f:
        return json.load(f)


def check_ttp_in_log(ttp, log_file):
    """Checks if a TTP indicator is present in the log file.

    Args:
        ttp (str): Threat Tactics and Techniques (TTP) indicator to search for.
        log_file (str): Path to the log file to search.

    Returns:
        bool: True if the TTP is found in the log, False otherwise.
    """

    with open(log_file, 'r') as f:
        log_content = f.read().lower()
        return ttp.lower() in log_content


def validate_group(group_name, ttp_database, log_file):
    """Validates a group of TTPs against a log file.

    Args:
        group_name (str): Name of the TTP group to validate.
        ttp_database (dict): Dictionary containing loaded TTP data.
        log_file (str): Path to the log file to search.
    """

    if group_name not in ttp_database:
        print(f"Group '{group_name}' not found in the database.")
        return

    ttps = ttp_database[group_name]
    detected_ttps = [ttp for ttp in ttps if check_ttp_in_log(ttp, log_file)]

    print(f"Group: {group_name}")
    print(f"Total TTPs: {len(ttps)}")
    print(f"Detected TTPs: {len(detected_ttps)}")

    if len(detected_ttps) == len(ttps):
        print("Validation successful: All TTPs detected.")
    else:
        print("Validation failed: Not all TTPs detected.")
        print("Missing TTPs:")
        for ttp in ttps:
            if ttp not in detected_ttps:
                print(f"- {ttp}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python main.py <group_name> <log_file>")
        sys.exit(1)

    group_name = sys.argv[1]
    log_file = sys.argv[2]  # Now get the log file path from the second argument
    ttp_database = load_ttp_database('ttp_database.json')
    validate_group(group_name, ttp_database, log_file)
