#!/bin/bash

#AUTOMATED PROJECT BOOTSTRAPPING - BSE SUMMATIVE
#Author: Samuel Epodoi


echo "Starting Automated Project Bootstrapping..."

#Ask the user for project name
read -p "Enter the project name: " input

#Here we validate to make sure the input variable above is not empty
if [ -z "$input" ]; then
    echo "The Project name cannot be empty."
    exit 1
fi

#Create Project Directory variable
PROJECT_DIR="attendance_tracker_${input}"
ARCHIVE_NAME="${PROJECT_DIR}_archive.tar.gz"

#Define Cleanup Login to handle when a user interrupts
cleanup() {
    echo ""
    echo "An Interrupt has been detected. Archiving project..."

    if [ -d "$PROJECT_DIR" ]; then
        tar -czf "$ARCHIVE_NAME" "$PROJECT_DIR"
        rm -rf "$PROJECT_DIR"
        echo "Archive created and incomplete directory removed."
    fi

    exit 1
}

#if user presses CTRL+C run cleanup() function above
trap cleanup SIGINT


#Prevent Overwriting an Existing Directory
if [ -d "$PROJECT_DIR" ]; then
    echo "That directory already exists. Exiting to prevent overwrite."
    exit 1
fi

#Create the DIRECTORY STRUCTURE
mkdir -p "$PROJECT_DIR/Helpers"
mkdir -p "$PROJECT_DIR/reports"
