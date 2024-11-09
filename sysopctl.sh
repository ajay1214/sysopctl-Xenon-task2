#!/bin/bash

# Version of the script
VERSION="v0.1.0"

# Color codes for printing colored text in the terminal
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"  # Reset color

# Function to display the help menu
function show_help {
    echo -e "${CYAN}${BOLD}Usage:${RESET} sysopctl [command] [options]"
    echo ""
    echo -e "  ${BOLD}Commands:${RESET}"
    echo -e "  ${GREEN}service list${RESET}           List all active services"
    echo -e "  ${GREEN}service start <name>${RESET}   Start a specific service"
    echo -e "  ${GREEN}service stop <name>${RESET}    Stop a specific service"
    echo -e "  ${GREEN}system load${RESET}            Show system load averages"
    echo -e "  ${GREEN}disk usage${RESET}             Show disk usage statistics"
    echo -e "  ${GREEN}process monitor${RESET}        Monitor real-time system processes"
    echo -e "  ${GREEN}logs analyze${RESET}           Analyze system logs"
    echo -e "  ${GREEN}backup <path>${RESET}          Backup system files to the specified path"
    echo ""
    echo -e "  ${BOLD}Options:${RESET}"
    echo -e "  ${YELLOW}--help${RESET}                 Show this help message"
    echo -e "  ${YELLOW}--version${RESET}              Show command version"
}

# Function to display the version of the script
function show_version {
    echo -e "${BLUE}${BOLD}sysopctl version $VERSION${RESET}"
}

# Function to list active services using the systemctl command
function list_services {
    echo -e "${YELLOW}${BOLD}Listing active services:${RESET}"
    systemctl list-units --type=service  # Lists all active systemd services
}

# Function to start a specific service
function start_service {
    service_name="$1"  # Name of the service passed as an argument
    if [ -z "$service_name" ]; then  # Check if no service name is provided
        echo -e "${RED}${BOLD}Error:${RESET} Service name is required."
        exit 1
    fi
    systemctl start "$service_name" && echo -e "${GREEN}Service '$service_name' started.${RESET}"
    # Start the service using systemctl, and display success message if the command succeeds
}

# Function to stop a specific service
function stop_service {
    service_name="$1"  # Name of the service passed as an argument
    if [ -z "$service_name" ]; then  # Check if no service name is provided
        echo -e "${RED}${BOLD}Error:${RESET} Service name is required."
        exit 1
    fi
    systemctl stop "$service_name" && echo -e "${GREEN}Service '$service_name' stopped.${RESET}"
    # Stop the service using systemctl, and display success message if the command succeeds
}

# Function to display system load averages
function system_load {
    echo -e "${YELLOW}${BOLD}System Load Averages:${RESET}"
    uptime  # Display system uptime and load averages
}

# Function to display disk usage statistics
function disk_usage {
    echo -e "${YELLOW}${BOLD}Disk Usage:${RESET}"
    df -h  # Show disk usage in a human-readable format
}

# Function to monitor system processes in real-time
function process_monitor {
    echo -e "${YELLOW}${BOLD}Monitoring Processes:${RESET}"
    top  # Run the 'top' command to monitor system processes in real-time
}

# Function to analyze system logs
function analyze_logs {
    echo -e "${YELLOW}${BOLD}Analyzing Logs:${RESET}"
    journalctl -p 3 -xb  # Display logs with priority 3 (errors) since the last boot
}

# Function to back up system files to a specified path
function backup_files {
    backup_path="$1"  # Path where the backup will be stored
    if [ -z "$backup_path" ]; then  # Check if no backup path is provided
        echo -e "${RED}${BOLD}Error:${RESET} Backup path is required."
        exit 1
    fi
    # Use rsync to copy all files from the root directory to the backup path, showing progress
    rsync -av --progress / "$backup_path" && echo -e "${GREEN}Backup to '$backup_path' completed.${RESET}"
}

# Main script logic to handle user input (commands and options)
case "$1" in
    --help)
        show_help  # Display help menu if --help option is passed
        ;;
    --version)
        show_version  # Display version if --version option is passed
        ;;
    service)
        case "$2" in
            list)
                list_services  # List services if 'service list' is passed
                ;;
            start)
                start_service "$3"  # Start a service if 'service start <name>' is passed
                ;;
            stop)
                stop_service "$3"  # Stop a service if 'service stop <name>' is passed
                ;;
            *)
                echo -e "${RED}Unknown service option. Use 'sysopctl --help' for usage.${RESET}"
                ;;
        esac
        ;;
    system)
        if [ "$2" == "load" ]; then
            system_load  # Show system load if 'system load' is passed
        else
            echo -e "${RED}Unknown system option. Use 'sysopctl --help' for usage.${RESET}"
        fi
        ;;
    disk)
        if [ "$2" == "usage" ]; then
            disk_usage  # Show disk usage if 'disk usage' is passed
        else
            echo -e "${RED}Unknown disk option. Use 'sysopctl --help' for usage.${RESET}"
        fi
        ;;
    process)
        if [ "$2" == "monitor" ]; then
            process_monitor  # Monitor processes if 'process monitor' is passed
        else
            echo -e "${RED}Unknown process option. Use 'sysopctl --help' for usage.${RESET}"
        fi
        ;;
    logs)
        if [ "$2" == "analyze" ]; then
            analyze_logs  # Analyze logs if 'logs analyze' is passed
        else
            echo -e "${RED}Unknown logs option. Use 'sysopctl --help' for usage.${RESET}"
        fi
        ;;
    backup)
        backup_files "$2"  # Backup files if 'backup <path>' is passed
        ;;
    *)
        echo -e "${RED}Unknown command. Use 'sysopctl --help' for usage.${RESET}"
        ;;
esac