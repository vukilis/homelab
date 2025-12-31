## Project Structure

Below is the detailed directory layout and the responsibility of each file:

```text
terraform/
└── proxmox/
    ├── live/                    # Implementation Layer (Environments)
        └── containers/
            ├── main.tf          # Calls the module and defines specific container instances
            ├── outputs.tf       # Displays final container IDs and IPs after deployment
            ├── provider.tf      # Proxmox API connection settings
            └── variables.tf     # Environment-specific variable definitions
        └── vms/
            ├── main.tf          # Calls the module and defines specific VM instances
            ├── outputs.tf       # Displays final VM IDs and IPs after deployment
            ├── provider.tf      # Proxmox API connection settings
            └── variables.tf     # Environment-specific variable definitions
    ├── modules/                 # Blueprint Layer (Reusable Code)
        └── proxmox_lxc/
            ├── main.tf          # The core resource logic for "proxmox_lxc"
            ├── outputs.tf       # Attributes exported from the module to the live layer
            └── variables.tf     # The required inputs (RAM, CPU, Disk) for the module
        └── proxmox_vms/
            ├── main.tf          # The core resource logic for "proxmox_vms"
            ├── outputs.tf       # Attributes exported from the module to the live layer
            └── variables.tf     # The required inputs (RAM, CPU, Disk) for the module
```

### 1. Initialize Project

Download providers and initialize the backend.

```bash
terraform init
```

### 2. Plan Infrastructure

Review the changes before they are made. This step is critical to avoid accidental deletions.

```bash
terraform plan
```

### 3. Apply Changes

Deploy the infrastructure to the proxmox.

```bash
terraform apply
```

### 4. Target Specific Deletion

To destroy a specific module (like a test environment) without affecting the entire stack:

```bash
terraform destroy -target=module.test-container-0
```

## Best Practices

* **Formatting**: Run `terraform fmt` to keep code clean.  
* **Validation**: Run `terraform validate` to ensure syntax   correctness.  


## Configuration Details

The `provider.tf` expects the following variables (ideally passed via .tfvars or ENV):

* pm_api_url
* pm_api_token_id
* pm_api_token_secret
* root_password
* pve_connection