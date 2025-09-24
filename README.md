# Safebackup (Bash)

A simple **backup + restore utility** written in Bash.  
This project demonstrates shell scripting, archiving, and checksum verification.

---

## Features
- Backup any directory (default: `/etc`)
- Archives as `.tar.gz`
- Adds **timestamp** to filename (`YYYY-MM-DDTHH:MM:SSZ`)
- Keeps only the **last N** backups (retention)
- Generates `.sha256` checksum for each backup
- Restore script automatically **verifies checksum** before extracting
- Works on Linux (tested on CentOS/RHEL)

---

## Project Structure
```
backup.sh     # create a backup
restore.sh    # restore from a backup
.gitignore    # ignore archives/checksums in Git
README.md     # this file
```

---

## Usage

### 1. Backup
```bash
chmod +x backup.sh
sudo ./backup.sh
```

**Output Example:**
```
localhost-backup-2025-09-24T19:01:52Z.tar.gz
localhost-backup-2025-09-24T19:01:52Z.tar.gz.sha256
```

---

### 2. Restore
```bash
chmod +x restore.sh
sudo ./restore.sh ~/backups/<archive>.tar.gz /tmp/restore_test
```

**Output Example:**
```
Verifying checksum...
<archive>.tar.gz: OK
Restoring --> /tmp/restore_test
Restore complete!
```

---

### 3. Verify Integrity
```bash
sha256sum -c ~/backups/<archive>.tar.gz.sha256
```

---

## Example
Backup `/etc` and restore into `/tmp/restore_test`:
```bash
sudo ./backup.sh
sudo ./restore.sh ~/backups/localhost-backup-2025-09-24T19:01:52Z.tar.gz /tmp/restore_test
```

---

## Notes
- Customize `SOURCE_DIR`, `BACKUP_DIR`, and `RETAIN_COUNT` inside `backup.sh`.
- By default, backups go to `~/backups`.
- Use `tree` (if installed) to view restored files, otherwise `ls -R`.

---

## License
This project is for learning purposes. Feel free to use and modify.







