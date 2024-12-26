# Mastering Network Intrusion Defense: Modules 5 and 6

This repository contains resources and scripts related to **Modules 5 and 6** of the EC-Council's advanced course on **Mastering Network Intrusion Defense**. Below is an overview of the content and usage of the files in this repository.

---

## Module 5: Testing Detections
This module focuses on creating and testing intrusion detection rules to ensure accurate threat identification.

### Files Included:
- **`Surracata_simulation.py`**: A Python script to simulate traffic for IDS testing.
- **`main.sh`**: A shell script to initialize and execute various IDS test cases.
- **`test_pcap_distribution.sh`**: A script to distribute and test PCAP files for IDS rule effectiveness.
- **`threat_group_check.py`**: A Python utility to validate threat detection against specific group behaviors.
- **`fast.log`**: Log files containing results of detection testing.

### Usage:
1. Run `main.sh` to start the simulation.
2. Use `test_pcap_distribution.sh` to validate PCAP inputs against custom IDS rules.
3. Review `fast.log` for detection outputs and refine rules as needed.

---

## Module 6: Automations and Extended Use Cases
This module covers automating IDS processes and integrating with CI/CD pipelines for seamless deployment.

### Files Included:
- **`github-suricata-deployment-runner.yaml`**: A GitHub Actions configuration file for automating Suricata deployments.
- **`sample_rule_deployment.sh`**: A script for deploying new rules to IDS.
- **`tcpkill.sh`**: A script for actively terminating malicious connections.
- **`records.log`**: Logs for monitoring IDS automation tasks and rule deployment performance.

### Usage:
1. Use `github-suricata-deployment-runner.yaml` to automate deployments within GitHub CI/CD workflows.
2. Execute `sample_rule_deployment.sh` to update IDS with new detection rules.
3. Run `tcpkill.sh` to actively monitor and terminate malicious network connections.
4. Review `records.log` for automation insights and debugging.

---

## Notes:
- Ensure Suricata and its dependencies are installed and configured correctly before running these scripts.
- Logs are generated in `fast.log` (Module 5) and `records.log` (Module 6) for analysis and troubleshooting.
- For any issues or contributions, feel free to create a pull request or raise an issue in this repository.

---

**Author:** Kanishk Ashra  
**Course:** EC-Council - Mastering Network Intrusion Defense
