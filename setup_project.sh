#!/bin/bash

#AUTOMATED PROJECT BOOTSTRAPPING - BSE SUMMATIVE
#Author: Samuel Epodoi


echo "Starting Automated Project Bootstrapping..."

#Ask the user for project name
read -p "Enter project name: " input

#Here we validate to make sure the input variable above is not empty
if [ -z "$input" ]; then
    echo "Project name cannot be empty."
    exit 1
fi

#Create Project Directory variable
PROJECT_DIR="attendance_tracker_${input}"
ARCHIVE_NAME="${PROJECT_DIR}_archive.tar.gz"

#Define Cleanup Login to handle when a user interrupts
