# Nix-OS Wazuh Log Forwarder
## Description
Welcome to the "LogForwarderConfig" repository! This project provides a comprehensive set of scripts and configurations to streamline the setup of a log forwarding system for Wazuh on NixOS. If you're looking to enhance your log management and security monitoring capabilities, this repository is your go-to resource.

## Features

- **Log Forwarding**: Our scripts simplify the process of setting up a log forwarding system that seamlessly connects with the Wazuh security information and event management (SIEM) platform.

- **Containerization**: We've included Docker and/or Podman configurations to containerize various components of the log forwarding system, ensuring easy deployment and scalability.

- **Configuration Management**: This repository includes sample configurations and templates to quickly adapt the log forwarding setup to your specific requirements. Easily customize the system according to your environment.

## Key Benefits

- **Simplified Setup**: Our scripts and documentation make it easy for NixOS users to set up a robust log forwarding system without the hassle of manual configurations.

- **Enhanced Security Monitoring**: By forwarding logs to Wazuh, you can improve your security posture by monitoring and analyzing events across your infrastructure.

- **Scalability**: Containerization enables you to scale your log forwarding infrastructure to match the needs of your growing environment.

- **Customization**: The provided configurations and templates allow you to tailor the system to your unique requirements.

## Getting Started

1. Install NixOS
   
3. Add git and Vim packages to NixOS configuration file uder /etc/nixos/configuration.nix
```Shell
  environment.systemPackages = with pkgs; [
  vim
  wget
  ];
```

4. Reboot system

5. Download and run this script

## Contributions and Feedback

I hope it helps you streamline your log management and security monitoring efforts. If you have any questions or need assistance, don't hesitate to reach out to our community or open an issue. Happy monitoring!
