#!/bin/bash

main="submission_reminder_app"

# To create the main directory and subdirectories
mkdir -p "$main/app" "$main/modules" "$main/assets" "$main/config"

# Create the required files
touch "$main/app/reminder.sh" "$main/modules/functions.sh" \
      "$main/assets/submissions.txt" "$main/config/config.env" \
      "$main/startup.sh"

# for functions.sh
cat << 'EOF' > "$main/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# for reminder.sh
cat << 'EOF' > "$main/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# for config.env
cat << 'EOF' > "$main/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Copy the submissions.txt in assets directory
cp ./submissions.txt "$main/assets/submissions.txt"

# Change directory to the main directory
cd "$main"

# five more additional student records
cat << 'EOF' >> assets/submissions.txt
Samuella, Shell Navigation, submitted
Ngabo, Shell Navigation, not submitted
Elie, Shell Navigation, submitted
Luke, Shell Navigation, not submitted
Divine, Shell Navigation, not submitted
EOF

# the startup script
cat << 'EOF' > ./startup.sh
#!/bin/bash

./app/reminder.sh
EOF
