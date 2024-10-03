#!/bin/bash

mkdir -p submission_reminder_app/{app,modules,assets,config}

cd submission_reminder_app

cat /c/Users/Samuella/Documents/reminder.sh > app/reminder.sh
cat /c/Users/Samuella/Documents/functions.sh > modules/functions.sh
cat /c/Users/Samuella/Documents/config.env > config/config.env
cat ../submissions.txt > assets/submissions.txt

# five more students
echo -e "Larrisa, Shell Navigation, submitted\nTonny, Shell Navigation, not submitted\nBienvenu, Shell Navigation, submitted\nGloria, Shell Navigation, submitted\nSam, Shell Navigation, not submitted" >> assets/submissions.txt

echo -e "#!/bin/bash\n./app/reminder.sh" >> startup.sh
