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

#CREATE THE REQUIRED FILES BELOW WITH THEIR DATA & RESPECTIVE DIRECTORIES
#Create attendance_checker.py
cat <<EOF > "$PROJECT_DIR/attendance_checker.py"
import json
import csv

def load_config():
    with open("Helpers/config.json") as f:
        return json.load(f)

def load_students():
    with open("Helpers/assets.csv") as f:
        reader = csv.DictReader(f)
        return list(reader)

def evaluate():
    config = load_config()
    students = load_students()

    warning_threshold = config["warning"]
    failure_threshold = config["failure"]

    for student in students:
        attendance = float(student["attendance"])

        if attendance < failure_threshold:
            status = "FAIL"
        elif attendance < warning_threshold:
            status = "WARNING"
        else:
            status = "PASS"

        print(f"{student['name']} - {attendance}% - {status}")

if __name__ == "__main__":
    evaluate()
EOF

#Create config.json
cat <<EOF > "$PROJECT_DIR/Helpers/config.json"
{
    "warning": 75,
    "failure": 50
}
EOF

#Create assets.csv
cat <<EOF > "$PROJECT_DIR/Helpers/assets.csv"
name,attendance
Alice,82
Bob,68
Charlie,45
Sam,92
Robert,67
Henry,22
EOF

#Create reports.log
cat <<EOF > "$PROJECT_DIR/reports/reports.log"
--- Attendance Report Run: 2026-02-06 18:10:01.468726 ---
[2026-02-06 18:10:01.469363] ALERT SENT TO bob@example.com: URGENT: Bob Smith, your attendance is 46.7%. You will fail this class.
[2026-02-06 18:10:01.469424] ALERT SENT TO charlie@example.com: URGENT: Charlie Davis, your attendance is 26.7%. You will fail this class.
EOF

#NEXT > We ask the user to update the threshold that are in config.json
read -p "IMPORTANT: Do you want to update attendance thresholds? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then

    read -p "Enter new warning threshold (default 75): " warning
    read -p "Enter new failure threshold (default 50): " failure

    if [[ ! "$warning" =~ ^[0-9]+$ ]]; then
        warning=75
    fi

    if [[ ! "$failure" =~ ^[0-9]+$ ]]; then
        failure=50
    fi

    sed -i '' "s/\"warning\":.*/\"warning\": $warning,/" "$PROJECT_DIR/Helpers/config.json"
    sed -i '' "s/\"failure\":.*/\"failure\": $failure/" "$PROJECT_DIR/Helpers/config.json"

    echo "Thresholds updated."
fi

#Environment Health Checkup
echo "Performing environment health check..."

if command -v python3 > /dev/null 2>&1; then
    echo "Python3 found:"
    python3 --version
else
    echo "WARNING: python3 is not installed."
fi

#Final Completion message
echo ""
echo "Project setup completed successfully!"
echo "Project directory: $PROJECT_DIR"
