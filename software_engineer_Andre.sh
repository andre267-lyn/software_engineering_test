# 1.	Pencarian File Berdasarkan Ekstensi file (MANAGEMENT FILE)

root@Revision-PC:/mnt/c/Users/Andre# cd Documents
root@Revision-PC:/mnt/c/Users/Andre/Documents# mkdir technical test
root@Revision-PC:/mnt/c/Users/Andre/Documents# touch search_files.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano search_files.sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <extension>"
    exit 1
fi

directory=$1
extension=$2

find "$directory" -type f -name "*.$extension" -print

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x search_files.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./search_files.sh "technical test" .sh

# 2.	Backup dan Kompresi File (MANAGEMENT FILE)
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano ~/backup_directory.sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_location>"
    exit 1
fi

source_directory=$1
backup_location=$2

backup_file="backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

if [ ! -d "$backup_location" ]; then
    echo "Lokasi backup tidak valid. Membuat direktori $backup_location."
    mkdir -p "$backup_location"
fi

tar -czf "$backup_location/$backup_file" "$source_directory"

echo "Backup berhasil! File backup disimpan di $backup_location/$backup_file"

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x ~/backup_directory.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano ~/backup_directory.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ~/backup_directory.sh "technical test" ~/backups
Lokasi backup tidak valid. Membuat direktori /root/backups.
Backup berhasil! File backup disimpan di /root/backups/backup_2024-05-29_22-58-36.tar.gz

# 3.	Menghitung dan Menampilkan Statistik File (MANAGEMENT FILE)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch file_stats.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano file_stats.sh

count_stats() {
  local file=$1
  local lines=$(wc -l < "$file")
  local words=$(wc -w < "$file")
  local chars=$(wc -m < "$file")
  echo "$file $lines $words $chars"
}

display_stats() {
  echo "File\tLines\tWords\tChars"
  for file in "$@"; do
    count_stats "$file"
  done
}

files=$(find "$1" -type f -name "*.txt")

display_stats $files

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x file_stats.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./file_stats.sh /mnt/c/Users/Andre/Documents
File\tLines\tWords\tChars
/mnt/c/Users/Andre/Documents/Intership/andre/DS-backend/DS-NewsService/notes.txt 6 33 262
/mnt/c/Users/Andre/Documents/Intership/andre/DS-backend/DS-PromoService/notes.txt 6 33 264
/mnt/c/Users/Andre/Documents/Intership/andre/DS-backend/DS-RegistryService/notes.txt 6 33 270
/mnt/c/Users/Andre/Documents/Intership/andre/DS-backend/DS-SpringGateway/notes.txt 6 33 266
/mnt/c/Users/Andre/Documents/Intership/andre/DS-backend/DS-UserService/notes.txt 6 33 262
/mnt/c/Users/Andre/Documents/Intership/backup/andre/DS-backend/DS-NewsService/notes.txt 6 33 262
/mnt/c/Users/Andre/Documents/Intership/backup/andre/DS-backend/DS-PromoService/notes.txt 6 33 264
/mnt/c/Users/Andre/Documents/Intership/backup/andre/DS-backend/DS-RegistryService/notes.txt 6 33 270
/mnt/c/Users/Andre/Documents/Intership/backup/andre/DS-backend/DS-SpringGateway/notes.txt 6 33 266
/mnt/c/Users/Andre/Documents/Intership/backup/andre/DS-backend/DS-UserService/notes.txt 6 33 262
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-NewsService/notes.txt 6 33 256
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-PromoService/notes.txt 6 33 258
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-RegistryService/notes.txt 6 33 264
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-SpringGateway/notes.txt 6 33 260
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-backend/DS-NewsService/notes.txt 6 33 262
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-backend/DS-PromoService/notes.txt 6 33 264
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-backend/DS-RegistryService/notes.txt 6 33 270
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-backend/DS-SpringGateway/notes.txt 6 33 266
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-backend/DS-UserService/notes.txt 6 33 262
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-NewsService/notes.txt 6 33 262
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-PromoService/notes.txt 6 33 264
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-RegistryService/notes.txt 6 33 270
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/DS-SpringGateway/notes.txt 6 33 266
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/DS-UserService/notes.txt 6 33 256
/mnt/c/Users/Andre/Documents/Intership/DS-backend-main/notes.txt 6 33 262

# 4.	Backup Direktori dan Rotasi Log (MANAGEMENT FILE)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch backup_dir.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# mkdir /mnt/c/Users/Andre/Backup
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano backup_dir.sh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <src_dir> <dest_dir>"
  exit 1
fi

if [! -d "$1" ]; then
  echo "Error: Direktori sumber '$1' tidak ada"
  exit 1
fi

if [! -d "$2" ]; then
  mkdir "$2"
fi

backup_file="$2/backup_$(date +%Y-%m-%d-%H%M%S).tar.gz"

tar czf "$backup_file" "$1"

find "$2" -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;

echo "Backup berhasil! File backup disimpan di $backup_file"

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x backup_dir.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./backup_dir.sh /mnt/c/Users/Andre/Documents /mnt/c/Users/Andre/Backup
Backup berhasil! File backup disimpan di /mnt/c/Users/Andre/Backup/backup_2024-05-29-232807.tar.gz

# 5.	Automasi Pembaharuan Sistem (BASIC SYSTEM)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch update_packages.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano update_packages.sh

if [[ $(cat /etc/os-release | grep "ID=ubuntu") ]]; then
    package_manager="apt-get"
elif [[ $(cat /etc/os-release | grep "ID=centos") ]]; then
    package_manager="yum"
else
    echo "Unsupported Linux family. Please install the package manager manually."
    exit 1
fi

$package_manager update -y > /var/log/package_updates.log 2>&1

if [ $(grep -c "failed" /var/log/package_updates.log) -gt 0 ]; then
    echo "There were errors during the package update. Please check the log file for details."
    exit 1
fi

echo "All packages have been successfully updated."

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x update_packages.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./update_packages.sh
All packages have been successfully updated.

# 6.	Membuat dan Menyimpan SSH Key (SSH)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch generate_ssh_key.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano generate_ssh_key.sh

DIREKTORI=$1

if [ -z "$DIREKTORI" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

if [ ! -d "$DIREKTORI" ]; then
  mkdir -p "$DIREKTORI"
fi

ssh-keygen -t rsa -b 4096 -f "$DIREKTORI/id_rsa" -C "bagusandren75@gmail.com"

echo "SSH key has been generated in $DIREKTORI/id_rsa and $DIREKTORI/id_rsa.pub"

root@Revision-PC:/mnt/c/Users/Andre/Documents/my_ssh_keys# ./generate_ssh_key.sh /mnt/c/Users/Andre/Documents/my_ssh_keys
Generating public/private rsa key pair.
/mnt/c/Users/Andre/Documents/my_ssh_keys/id_rsa already exists.
Overwrite (y/n)? y
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /mnt/c/Users/Andre/Documents/my_ssh_keys/id_rsa
Your public key has been saved in /mnt/c/Users/Andre/Documents/my_ssh_keys/id_rsa.pub
The key fingerprint is:
SHA256:WLNpKkkWkbS2w6cVk7p05heha+GErZraHHFpK+QyWYU bagusandren75@gmail.com
The key's randomart image is:
+---[RSA 4096]----+
|   .o.           |
|   ..o .         |
|  E = + +        |
|   + B * =       |
|  + & @ S        |
| = B / = .       |
|+ + B * .        |
| = = o .         |
|..=              |
+----[SHA256]-----+
SSH key has been generated in /mnt/c/Users/Andre/Documents/my_ssh_keys/id_rsa and /mnt/c/Users/Andre/Documents/my_ssh_keys/id_rsa.pub


# 7. Mengcopy public key ke server remote (SSH)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch generate_ssh_key.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano generate_ssh_key.sh

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <public_key_file> <username> <server_ip>"
    exit 1
fi

PUBLIC_KEY_FILE=$1
USERNAME=$2
SERVER_IP=$3

if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: File $PUBLIC_KEY_FILE not found!"
    exit 1
fi

PUBLIC_KEY_CONTENT=$(cat "$PUBLIC_KEY_FILE")

ssh "$USERNAME@$SERVER_IP" "mkdir -p ~/.ssh && echo \"$PUBLIC_KEY_CONTENT\" >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh"

if [ $? -eq 0 ]; then
    echo "Public key has been copied successfully to $USERNAME@$SERVER_IP"
else
    echo "Failed to copy the public key to $USERNAME@$SERVER_IP"
    exit 1
fi

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x copy_key.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./copy_key.sh /path/to/public_key_file.pub username server_ip


# 8. Mengecheck Koneksi SSH ke Server Remote (SSH)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch check_ssh_connection.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano check_ssh_connection.sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username> <server_ip>"
    exit 1
fi

USERNAME=$1
SERVER_IP=$2

ssh -o BatchMode=yes -o ConnectTimeout=5 "$USERNAME@$SERVER_IP" "exit"

if [ $? -eq 0 ]; then
    echo "SSH connection to $USERNAME@$SERVER_IP was successful."
else
    echo "SSH connection to $USERNAME@$SERVER_IP failed."
fi


root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x check_ssh_connection.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./check_ssh_connection.sh username server_ip


# 9. Membuat Script untuk Menambahkan SSH Key ke ‘authorized_keys’ (SSH)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch add_ssh_key_local.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano add_ssh_key_local.sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <public_key_file> <username>"
    exit 1
fi

PUBLIC_KEY_FILE=$1
USERNAME=$2

if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: File $PUBLIC_KEY_FILE not found!"
    exit 1
fi

PUBLIC_KEY_CONTENT=$(cat "$PUBLIC_KEY_FILE")

sudo -u "$USERNAME" bash -c "mkdir -p ~/.ssh && echo \"$PUBLIC_KEY_CONTENT\" >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh"

if [ $? -eq 0 ]; then
    echo "Public key has been successfully added to $USERNAME's authorized_keys."
else
    echo "Failed to add the public key to $USERNAME's authorized_keys."
    exit 1
fi

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x add_ssh_key_local.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./add_ssh_key_local.sh /path/to/public_key_file.pub username

# 10. Menghapus SSH Key dari ‘authorized_keys’ (SSH)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch remove_ssh_key_local.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano remove_ssh_key_local.sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <unique_string> <username>"
    exit 1
fi

UNIQUE_STRING=$1
USERNAME=$2

AUTHORIZED_KEYS_FILE="/home/$USERNAME/.ssh/authorized_keys"

if [ ! -f "$AUTHORIZED_KEYS_FILE" ]; then
    echo "Error: File $AUTHORIZED_KEYS_FILE not found!"
    exit 1
fi

sudo -u "$USERNAME" bash -c "grep -v \"$UNIQUE_STRING\" $AUTHORIZED_KEYS_FILE > $AUTHORIZED_KEYS_FILE.tmp && mv $AUTHORIZED_KEYS_FILE.tmp $AUTHORIZED_KEYS_FILE"

if [ $? -eq 0 ]; then
    echo "Public key containing '$UNIQUE_STRING' has been successfully removed from $USERNAME's authorized_keys."
else
    echo "Failed to remove the public key containing '$UNIQUE_STRING' from $USERNAME's authorized_keys."
    exit 1
fi

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x remove_ssh_key_local.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./remove_ssh_key_local.sh unique_string username
Public key containing 'unique_string' has been successfully removed from username's authorized_keys.


# 11. Pengelolaan Service (SERVICE)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch manage_service.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano manage_service.sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <action> <service_name>"
    echo "Actions: start, stop, status"
    exit 1
fi

ACTION=$1
SERVICE=$2

case "$ACTION" in
    start)
        systemctl start "$SERVICE"
        if [ $? -eq 0 ]; then
            echo "Service $SERVICE started successfully."
        else
            echo "Failed to start service $SERVICE."
        fi
        ;;
    stop)
        systemctl stop "$SERVICE"
        if [ $? -eq 0 ]; then
            echo "Service $SERVICE stopped successfully."
        else
            echo "Failed to stop service $SERVICE."
        fi
        ;;
    status)
        systemctl status "$SERVICE"
        if [ $? -eq 0 ]; then
            echo "Service $SERVICE is running."
        else
            echo "Service $SERVICE is not running."
        fi
        ;;
    *)
        echo "Invalid action: $ACTION"
        echo "Usage: $0 <action> <service_name>"
        echo "Actions: start, stop, status"
        exit 1
        ;;
esac

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x manage_service.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./manage_service.sh start apache2
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./manage_service.sh stop apache2
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./manage_service.sh status apache2
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./manage_service.sh start apache2
Service apache2 started successfully.
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./manage_service.sh stop apache2
Service apache2 stopped successfully.
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./manage_service.sh status apache2
● apache2.service - The Apache HTTP Server
   Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2024-05-31 12:34:56 UTC; 5min ago
...
Service apache2 is running.


# 12. Men-copy Direktori ke Server Remote (SCP)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch scp_copy.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano scp_copy.sh

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_file> <username> <server_ip>"
    exit 1
fi

SOURCE_FILE=$1
USERNAME=$2
SERVER_IP=$3

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: File $SOURCE_FILE not found!"
    exit 1
fi

scp "$SOURCE_FILE" "$USERNAME@$SERVER_IP:~"

if [ $? -eq 0 ]; then
    echo "File $SOURCE_FILE successfully copied to $USERNAME@$SERVER_IP:~/"
else
    echo "Failed to copy file $SOURCE_FILE to $USERNAME@$SERVER_IP:~/"
fi

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x scp_copy.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./scp_copy.sh /path/to/source_file username server_ip
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano rsync_copy.sh

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_file> <username> <server_ip>"
    exit 1
fi

SOURCE_FILE=$1
USERNAME=$2
SERVER_IP=$3

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: File $SOURCE_FILE not found!"
    exit 1
fi

rsync -avz "$SOURCE_FILE" "$USERNAME@$SERVER_IP:~/"

if [ $? -eq 0 ]; then
    echo "File $SOURCE_FILE successfully copied to $USERNAME@$SERVER_IP:~/ using rsync"
else
    echo "Failed to copy file $SOURCE_FILE to $USERNAME@$SERVER_IP:~/ using rsync"
fi

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x rsync_copy.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./rsync_copy.sh /path/to/source_file username server_ip
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./scp_copy.sh /path/to/example.txt username server_ip
File /path/to/example.txt successfully copied to username@server_ip:~/
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./rsync_copy.sh /path/to/example.txt username server_ip
File /path/to/example.txt successfully copied to username@server_ip:~/ using rsync


# 13. Membuat Unit File Systemd untuk Service Sederhana (SERVICE)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch /usr/local/bin/simple_service.py
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano /usr/local/bin/simple_service.py

import time

while True:
    print("Simple Service is running...")
    time.sleep(60)

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x /usr/local/bin/simple_service.py
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano create_systemd_service.sh

PYTHON_SCRIPT="/usr/local/bin/simple_service.py"

if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "Error: Python script $PYTHON_SCRIPT not found!"
    exit 1
fi

SERVICE_FILE="/etc/systemd/system/simple_service.service"

sudo bash -c "cat > $SERVICE_FILE" <<EOL
[Unit]
Description=Simple Python Service
After=network.target

[Service]
ExecStart=/usr/bin/env python3 $PYTHON_SCRIPT
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload

systemctl enable simple_service.service

echo "Systemd service file $SERVICE_FILE created and enabled."

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x create_systemd_service.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./create_systemd_service.sh
Systemd service file /etc/systemd/system/simple_service.service created and enabled.
root@Revision-PC:/mnt/c/Users/Andre/Documents# systemctl start simple_service.service
root@Revision-PC:/mnt/c/Users/Andre/Documents# systemctl stop simple_service.service
root@Revision-PC:/mnt/c/Users/Andre/Documents# systemctl status simple_service.service
root@Revision-PC:/mnt/c/Users/Andre/Documents# systemctl start simple_service.service
root@Revision-PC:/mnt/c/Users/Andre/Documents# systemctl status simple_service.service
● simple_service.service - Simple Python Service
   Loaded: loaded (/etc/systemd/system/simple_service.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2024-05-31 12:34:56 UTC; 5s ago
 Main PID: 1234 (python3)
    Tasks: 1 (limit: 4915)
   CGroup: /system.slice/simple_service.service
           └─1234 /usr/bin/python3 /usr/local/bin/simple_service.py

root@Revision-PC:/mnt/c/Users/Andre/Documents# systemctl stop simple_service.service
root@Revision-PC:/mnt/c/Users/Andre/Documents# systemctl status simple_service.service
● simple_service.service - Simple Python Service
   Loaded: loaded (/etc/systemd/system/simple_service.service; enabled; vendor preset: enabled)
   Active: inactive (dead) since Thu 2024-05-31 12:35:56 UTC; 5s ago


# 14. Memonitoring Penggunaan CPU (MONITORING)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch monitor_cpu.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano monitor_cpu.sh

LOG_FILE="/var/log/cpu_usage.log"

if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

CPU_USAGE=$(awk '{print $1*100}' /proc/loadavg)

THRESHOLD=75.0

if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$TIMESTAMP - CPU usage is above threshold: ${CPU_USAGE}%" >> "$LOG_FILE"
    echo "CPU usage recorded in log file."
else
    echo "CPU usage is within normal range: ${CPU_USAGE}%"
fi

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x monitor_cpu.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./monitor_cpu.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./monitor_cpu.sh
CPU usage is within normal range: 23.5%
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./monitor_cpu.sh
CPU usage recorded in log file.
root@Revision-PC:/mnt/c/Users/Andre/Documents# cat /var/log/cpu_usage.log
2024-05-31 12:45:30 - CPU usage is above threshold: 82.5%


# 15. Monitoring Penggunaan Disk (MONITORING)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch monitor_disk.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano monitor_disk.sh

THRESHOLD=80

EMAIL="your-email@example.com"

DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
   
    SUBJECT="Disk Usage Alert"
    MESSAGE="Warning: Disk usage is above $THRESHOLD%. Current usage is ${DISK_USAGE}%."
    echo "$MESSAGE" | mail -s "$SUBJECT" "$EMAIL"
    echo "Disk usage is above threshold: ${DISK_USAGE}%. Notification sent to $EMAIL."
else
    echo "Disk usage is within normal range: ${DISK_USAGE}%."
fi

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x monitor_disk.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./monitor_disk.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./monitor_disk.sh
Disk usage is within normal range: 45%.
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./monitor_disk.sh
Disk usage is above threshold: 85%. Notification sent to your-email@example.com.

Subject: Disk Usage Alert

Warning: Disk usage is above 80%. Current usage is 85%.


# 16. Menampilan Informasi Sistem (MONITORING)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch monitor_system.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano monitor_system.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano monitor_system.sh

hostname=$(hostname)

current_time=$(date)

logged_in_users=$(who | wc -l)

echo "Informasi Sistem:"
echo "-----------------"
echo "Nama Host: $hostname"
echo "Waktu Sistem Saat Ini: $current_time"
echo "Jumlah Pengguna yang Sedang Login: $logged_in_users"

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x monitor_system.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./monitor_system.sh

Informasi Sistem:
-----------------
Nama Host: Revision-PC
Waktu Sistem Saat Ini: Mon May 31 14:30:00 UTC 2024
Jumlah Pengguna yang Sedang Login: 1


# 17. Pengaturan Firewall dengan `iptables` (NETWORK)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch configure_firewall.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano configure_firewall.sh

iptables -F

iptables -P OUTPUT ACCEPT

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

iptables -P INPUT DROP

iptables -L -n

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x configure_firewall.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./configure_firewall.sh

Chain INPUT (policy DROP)
target     prot opt source               destination
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:22
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:80
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:443

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination


# 18. Konfigurasi Jaringan dengan ‘netplan’ (NETWORK)

root@Revision-PC:/mnt/c/Users/Andre/Documents# touch configure_network.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# nano configure_network.sh

netplan_config="network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses: [192.168.1.100/24]
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]"

echo "$netplan_config" > /etc/netplan/01-network.yaml

netplan apply

root@Revision-PC:/mnt/c/Users/Andre/Documents# chmod +x configure_network.sh
root@Revision-PC:/mnt/c/Users/Andre/Documents# ./configure_network.sh

root@Revision-PC:/mnt/c/Users/Andre/Documents# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.100/24 brd 192.168.1.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 xxxx::xxxx:xxxx:xxxx:xxxx/64 scope link
       valid_lft forever preferred_lft forever

root@Revision-PC:/mnt/c/Users/Andre/Documents# ip route
default via 192.168.1.1 dev eth0 proto static
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100





