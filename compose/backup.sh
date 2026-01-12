#!/bin/bash

# Start the SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/vuk.lekic

# List of servers                                   # Unncoment to include in backup
declare -A server_names=(
    # ["192.168.0.201"]="uptime-kuma"               # Manual installation
    # ["192.168.0.202"]="adguard"                   # Proxmox VE Helper-Scripts
    # ["192.168.0.203"]="homepage"                  # Manual installation   
    # ["192.168.0.204"]="qbittorrent"               # Proxmox VE Helper-Scripts
    # ["192.168.0.205"]="navidrome"                 # Manual installation
    # ["192.168.0.206"]="filebrowser"               # Manual installation
    # ["192.168.0.207"]="vaultwarden"               # Manual installation
    # ["192.168.0.208"]="proxmox-backup-server"     # Proxmox VE Helper-Scripts
    # ["192.168.0.209"]="nginxproxymanager"         # Proxmox VE Helper-Scripts
    # ["192.168.0.210"]="medusa"                    # Manual installation
    # ["192.168.0.211"]="authentik"                 # Proxmox VE Helper-Scripts
    # ["192.168.0.212"]="usememos"                  # Manual installation
    # ["192.168.0.213"]="cloudflared"               # Proxmox VE Helper-Scripts
    # ["192.168.0.214"]="wallos"                    # Manual installation
    # ["192.168.0.215"]="watchyourlan"              # Manual installation
    # ["192.168.0.216"]="dozzle"                    # Manual installation 
    # ["192.168.0.217"]="traccar"                   # Manual installation
    # ["192.168.0.218"]="pocketid"                  # Proxmox VE Helper-Scripts
    # ["192.168.0.219"]="jetlog"                    # Manual installation
    # ["192.168.0.220"]="alpine-it-tools"           # Manual installation
    # ["192.168.0.221"]="home-assistant"            # Manual installation
    # ["192.168.0.222"]="twingate"                  # Manual installation
    # ["192.168.0.223"]="grafana"                   # Manual installation
    # ["192.168.0.224"]="beszel"                    # Manual installation
    # ["192.168.0.225"]="speedtest"                 # Manual installation
    # ["192.168.0.226"]="mealie"                    # Manual installation
    # ["192.168.0.227"]="linkstack"                 # Manual installation
    # ["192.168.0.229"]="n8n"                       # Manual installation
    # ["192.168.0.230"]="whatsupdocker"             # Manual installation
    # ["192.168.0.231"]="komodo"                    # Manual installation
    # ["192.168.0.232"]="wikidocs"                  # Manual installation
    # ["192.168.0.233"]="yaade"                     # Manual installation
)

# Display Table of Servers
keys=("${!server_names[@]}")
columns=4
rows=$(( (${#keys[@]} + columns - 1) / columns ))

echo "🖥️  Targeting servers:"
for ((r=0; r<rows; r++)); do
    for ((c=0; c<columns; c++)); do
        idx=$(( r + c * rows ))
        if [[ $idx -lt ${#keys[@]} ]]; then
            printf "%-25s" "${server_names[${keys[idx]}]} (${keys[idx]})"
        fi
    done
    echo
done
echo "----------------------------------------------------"

# Configuration
REMOTE_USER="homelab"
REMOTE_BASE_PATH="/home/homelab/stack/repos/homelab/compose"
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

SSH_OPTS="-q -o ControlMaster=auto -o ControlPath=/tmp/ssh-%r@%h:%p -o ControlPersist=10m"

for server_ip in "${!server_names[@]}"; do
    server_name="${server_names[$server_ip]}"
    target_path="$REMOTE_BASE_PATH/$server_name"
    
    echo "🔵 Processing $server_name ($server_ip)..."

    if ssh $SSH_OPTS -i ~/.ssh/vuk.lekic "$REMOTE_USER@$server_ip" "[ -d '$target_path' ]"; then
        echo "    ✅ Directory found. Syncing..."
        dest_dir="$SCRIPT_DIR/$server_name"
        mkdir -p "$dest_dir"
        rsync -az -e "ssh $SSH_OPTS -i ~/.ssh/vuk.lekic" --exclude='tmp/' "$REMOTE_USER@$server_ip:$target_path/" "$dest_dir/"
        echo "    ✨ Sync Complete: $dest_dir"
    else
        echo "    ❌ Error: Directory $target_path not found on $server_ip"
    fi
done

ssh-agent -k
echo "✅ All tasks complete!"