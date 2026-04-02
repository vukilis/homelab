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

Run the main playbook:

```bash
ansible-playbook site.yml -i hosts -e '{"hosts":"containers", "remote_user":"homelab"}'
```

* Check Connectivity: `ansible all -m ping -i hosts`
* Dry Run (Check mode): `ansible-playbook site.yml -i hosts --check`