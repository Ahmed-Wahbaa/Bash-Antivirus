# Antivirus Daemon and restore utility 

##overview and folder Structure
This project provides a simple antivirus daemon that monitors a given for malicious files (by extention or keyword content) and quarantines them also it provides an interactive restore utility to mange 
quarantined files and maintain a whitelist of false positives

antivirusd.sh (Antivirus monitoring daemon script)
restore.sh (Interactive restore utilty)
antivirus-cron.sh (single-pass scan script for cron scheduling)(bounus 1)
whitelist.txt (persistent whitelist for safe files)(bounus 2)
Makefile (Build and automation file)
READ.md (Project documentation)

