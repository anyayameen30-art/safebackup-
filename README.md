# Safebackup (Bash)

A simple **backup + restore utility** written in Bash.  
This project demonstrates shell scripting, archiving, and checksum verification.

---

#Features
- Backup any directory (default: `/etc`)
- Archives as `.tar.gz`
- Adds **timestamp** to filename (`YYYY-MM-DDTHH:MM:SSZ`)
- Keeps only the **last N** backups (retention)
- Generates `.sha256` checksum for each backup
- Restore script automatically **verifies checksum** before extracting
- Works on Linux (tested on CentOS/RHEL)

---

#Project Structure
1. backup.sh # create a backup
2. restore.sh # restore from a backup
3. .gitignore # ignore archives/checksums in Git
4. README.md # this file

#Usage
1. Backup
- chmod +x backup.sh
- sudo ./backup.sh

#Output Example:
localhost-backup-2025-09-24T19:01:52Z.tar.gz
localhost-backup-2025-09-24T19:01:52Z.tar.gz.sha256

2. Restore
- chmod +x restore.sh
- sudo ./restore.sh ~/backups/<archive>.tar.gz /tmp/restore_test

#Output Example:
Verifying checksum...
<archive>.tar.gz: OK
Restoring --> /tmp/restore_test
Restore complete!

#Verify Integrity
sha256sum -c ~/backups/<archive>.tar.gz.sha256

#Example:Backup /etc and restore into /tmp/restore_test:
sudo ./backup.sh
sudo ./restore.sh ~/backups/localhost-backup-2025-09-24T19:01:52Z.tar.gz /tmp/restore_test







