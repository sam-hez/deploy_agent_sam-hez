# Student Attendance Tracker Script Overview
Author: Samuel Hezekiah Epodoi - C2 BSE

A simple script that automatically creates the complete project structure for the Student Attendance Tracker.

### How to run

1. Make the script executable:

```bash
chmod +x setup_project.sh
```

2. Run it:

```bash
./setup_project.sh
```

3. Follow the prompts:

- Enter a name for your project.
- Choose whether to update warning/failure thresholds. If you say yes, enter new percentage values. If you press Enter without typing values, default thresholds are used.

### What gets created

After running, you will have a folder named `attendance_tracker_<yourname>` containing:

- `attendance_checker.py` — the main Python program
- `Helpers/` folder with `assets.csv` and `config.json`
- `reports/` folder with an empty `reports.log`

### Archive feature (Ctrl+C)

If you press Ctrl+C while the setup script is running, the script will:

a) Create a backup archive of everything created so far named `attendance_tracker_<yourname>_archive` (tar.gz)
b) Delete the incomplete project folder to keep the workspace clean
c) Exit cleanly

### How to test the archive feature

1. Run `./setup_project.sh`.
2. Enter a project name.
3. While files are being created, press Ctrl+C.

You should see an archive file named like `attendance_tracker_yourname_archive.tar.gz` that contains the partial project.

### Final check (Python)

The script checks if Python 3 is installed by running `python3 --version`.

- If Python 3 is found, the script prints the version (for example: "Python 3.10.4 installed").
- If Python 3 is missing, it warns you that Python 3 is not installed.

### Assignment notes

This script implements the project factory required for the Individual Summative Lab. It creates the required directory structure, optionally updates thresholds in `config.json`, and handles SIGINT (Ctrl+C) by archiving and cleaning up.
