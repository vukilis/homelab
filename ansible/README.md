## Project Structure

Below is the detailed directory layout and the responsibility of each file:

```text
ansible/
├── roles/                        
│   └── common/                   # this hierarchy represents a "role"
│       ├── tasks/                
│       │   └── main.yml          # Main execution logic
│       ├── handlers/             
│       │   └── main.yml          # Service notification logic
│       ├── templates/            
│       │   └── config.j2         # Dynamic configuration files
│       ├── files/                
│       │   └── bar.txt           # Files for use with the copy resource
│       │   └── foo.sh            # Script files for use with the script resource
│       └── vars/                 
│           └── main.yml          # Fixed role variables (highest priority)
│
├── ansible.cfg                   # Global configuration
├── hosts                         # Playbook targeting specific roles/hosts
├── site.yml                      # The "Master" Playbook
└── users.yml                     # A playbook file focused on user/group management
```

## 1. SSH Agent Setup

Before running any playbooks, ensure your SSH agent is running and your private key is loaded. This allows Ansible to authenticate with the remote nodes.

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/vuk.lekic
```

### 2. Create And Activate The Virtual Environment

```bash
python3 -m venv venv
source venv/bin/activate
```

### 3. Install Requirements And Collections

```bash
pip install ansible passlib
ansible-galaxy collection install community.general ansible.posix community.docker
```

### 4 Check 

```bash
ansible --version
```

> NOTE: Executable location should change to: executable location = `~/homelab/ansible/venv/bin/ansible`

### 3. Usage

Run the main playbook by targeting specific host groups and defining role flags via extra variables (`-e`).

* **Core Deployment Commands**

| Task | Command |
| :--- | :--- |
| **Standard Setup** | `ansible-playbook site.yml -i hosts -e '{"hosts":"containers", "remote_user":"homelab"}'` |
| **Debian Roles (Root)** | `ansible-playbook site.yml -i hosts -e '{"hosts":"containers", "remote_user":"root", "debian_containers":true}'` |
| **Alpine Roles (Root)** | `ansible-playbook site.yml -i hosts -e '{"hosts":"containers", "remote_user":"root", "alpine_containers":true, "gather_facts":false}'` |

* **System Hardening**

Use the `-K` flag to prompt for the `sudo` password for the `homelab` user.

```bash
ansible-playbook site.yml -i hosts -e '{"hosts":"containers", "remote_user":"homelab", "debian_containers_hardened":true}' -K
```

* **Docker & Agent Deployment**

Installs Docker with the Comodo agent.

```bash
ansible-playbook site.yml -i hosts -e '{"hosts":"containers", "remote_user":"homelab", "debian_install_docker":true, "debian_comodo_agent_docker":true}' -K
```

* **Monitoring Agents (Dozzle)**

Prepares and deploys the Dozzle agent.

```bash
ansible-playbook site.yml -i hosts -e '{"hosts":"containers", "remote_user":"homelab", "prepare_dozzle_agent":true}' -K
```

### **Flags & Variable Definitions**

| Variable / Flag | Description |
| :--- | :--- |
| **`hosts`** | Target group or specific host from the inventory (e.g., `test-container-0`). |
| **`remote_user`** | The SSH user account (`root` for initial builds or `homelab` for managed nodes). |
| **`gather_facts`** | Set to `false` when bootstrapping **Alpine** containers that lack a Python environment. |
| **`-K`** | `--ask-become-pass`: Mandatory when running tasks as the `homelab` user to prompt for `sudo` privileges. |