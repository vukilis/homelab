#!/bin/bash

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add SSH key to the agent
ssh-add ~/.ssh/vuk.lekic

# List of servers                                   # Unncoment to include in backup
declare -A server_names=(
    # ["192.168.0.201"]="uptime-kuma"               # Manual installation
    # ["192.168.0.202"]="adguard"                   # Proxmox VE Helper-Scripts
    ["192.168.0.203"]="homepage"                  # Manual installation   
    # ["192.168.0.204"]="qbittorrent"               # Proxmox VE Helper-Scripts
    # ["192.168.0.205"]="navidrome"                 # Manual installation
    # ["192.168.0.206"]="fileBrowser-quantum"       # Manual installation
    # ["192.168.0.207"]="vaultwarden"               # Manual installation
    # ["192.168.0.208"]="proxmox-backup-server"     # Proxmox VE Helper-Scripts
    # ["192.168.0.209"]="nginxproxymanager"         # Proxmox VE Helper-Scripts
    # ["192.168.0.210"]="medusa"                    # Manual installation
    # ["192.168.0.211"]="authentik"                 # Proxmox VE Helper-Scripts
    # ["192.168.0.212"]="usememos"                  # Manual installation
    # ["192.168.0.213"]="cloudflared"               # Proxmox VE Helper-Scripts
    # ["192.168.0.214"]="wallos"                    # Proxmox VE Helper-Scripts
    # ["192.168.0.215"]="watchyourlan"              # Proxmox VE Helper-Scripts
    # ["192.168.0.216"]="hoarder"                   # Proxmox VE Helper-Scripts   
    # ["192.168.0.217"]="traccar"                   # Manual installation
    # ["192.168.0.218"]="pocketid"                  # Proxmox VE Helper-Scripts
    # ["192.168.0.219"]="jetlog"                    # Manual installation
    # ["192.168.0.220"]="alpine-it-tools"           # Proxmox VE Helper-Scripts
    # ["192.168.0.221"]="home-assistant"            # Manual installation
    # ["192.168.0.222"]="twingate"                  # Manual installation
    # ["192.168.0.223"]="grafana"                   # Manual installation
    # ["192.168.0.224"]="beszel"                    # Manual installation
    # ["192.168.0.225"]="stash"                     # Manual installation
    # ["192.168.0.226"]="mealie"                    # Manual installation
    # ["192.168.0.227"]="linkstack"                 # Manual installation
)

servers=(
    "192.168.0.201" "192.168.0.202" "192.168.0.203" "192.168.0.204" "192.168.0.205"
    "192.168.0.206" "192.168.0.207" "192.168.0.208" "192.168.0.209" "192.168.0.210"
    "192.168.0.211" "192.168.0.212" "192.168.0.213" "192.168.0.214" "192.168.0.215"
    "192.168.0.216" "192.168.0.217" "192.168.0.218" "192.168.0.219" "192.168.0.220"
    "192.168.0.221" "192.168.0.222" "192.168.0.223" "192.168.0.224" "192.168.0.225"
    "192.168.0.226" "192.168.0.227"
)

columns=4
rows=$(( (${#servers[@]} + columns - 1) / columns ))

for ((r=0; r<rows; r++)); do
    for ((c=0; c<columns; c++)); do
        idx=$(( r + c * rows ))
        if [[ $idx -lt ${#servers[@]} ]]; then
        printf "%-20s" "${servers[idx]}"
        fi
    done
        echo
done

# Base destination folder
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Path for backup on remote servers
remote_config_paths_201="/root/uptime-kuma/compose.yml"
remote_config_paths_203="/root/homepage/config/bookmarks.yaml /root/homepage/config/docker.yaml /root/homepage/config/services.yaml /root/homepage/config/settings.yaml /root/homepage/config/widgets.yaml /root/homepage/config/custom.css /root/homepage/compose.yml /root/homepage/icons"
remote_config_paths_205="/root/navidrome/compose.yml"
remote_config_paths_206="/home/homelab/filebrowser/compose.yml /home/homelab/filebrowser/data"
remote_config_paths_207="/root/vaultwarden/compose.yml"
remote_config_paths_210="/home/homelab/medusa/compose.yml"
remote_config_paths_212="/root/usememos/compose.yml"
remote_config_paths_216="/root/hoarder/compose.yml"
remote_config_paths_217="/home/homelab/traccar/compose.yml /home/homelab/traccar/traccar.xml"
remote_config_paths_219="/root/jetlog/compose.yml "
remote_config_paths_221="/home/homelab/home-assistant/compose.yml"
remote_config_paths_222="/home/homelab/twingate/compose.yml"
remote_config_paths_223="/home/homelab/grafana/compose.yml /home/homelab/grafana/config"
remote_config_paths_224="/home/homelab/beszel/compose.yml"
remote_config_paths_225="/home/homelab/stash/compose.yml"
remote_config_paths_226="/home/homelab/mealie/compose.yml"
remote_config_paths_227="/home/homelab/linkstack/compose.yml"

# Loop through servers
for server_ip in "${!server_names[@]}"; do
    server_name="${server_names[$server_ip]}"
    echo "🔵 Processing $server_name ($server_ip)..."
    
    # Get the paths for this server
    paths_var="remote_config_paths_${server_ip##*.}"
    remote_paths="${!paths_var}"

    if [[ -z "$remote_paths" ]]; then
        echo "  ⚠️  No paths defined for $server_name, skipping."
        continue
    fi

    for path in $remote_paths; do
        echo "    📂 Copying from $path..."

        # Check if path exists on remote for both root and homelab users
        for user in root homelab; do
            if ssh -i ~/.ssh/vuk.lekic "$user@$server_ip" "[ -e '$path' ]"; then
                echo "    ✅ Path $path found for $user on $server_ip"

                # Calculate relative path
                # rel_path=$(echo "$path" | sed -E 's|^/root/[^/]+/||')

                # Calculate relative path for both /root and /home/homelab
                rel_path=$(echo "$path" | sed -E 's|^/root/[^/]+/||; s|^/home/homelab/[^/]+/||')

                # Create destination directory
                dest_dir="$SCRIPT_DIR/$server_name/$(dirname "$rel_path")"
                mkdir -p "$dest_dir"

                # Copy the file or folder
                scp -i ~/.ssh/vuk.lekic -r "$user@$server_ip:$path" "$dest_dir/"
                
                echo "    ✅ Copied: $dest_dir/$(basename "$path")"
                break
            else
                echo "    ❌ Path $path not found for $user on $server_ip"
            fi
        done
    done
done

echo "✅ All done!"

# Stop the SSH agent
ssh-agent -k