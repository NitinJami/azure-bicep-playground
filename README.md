# Get your Bicep done

Azure CLI can directly read bicep files. No need to complie to ARM templates required for Powershell modules.

To validate, use Azure's what-if sub-command to verify deployment:

```powershell
az deployment sub what-if --location <location> --template-file <path-to-bicep> --parameter SSHPubKey=$PubKey
```

To Deploy, use the following command passing in the `location` parameter:

```powershell
az deployment sub create --location <location> --template-file <path-to-bicep> --parameter SSHPubKey=$PubKey
```

## Things to do

1. Deploy Azure resources via Bicep.
    1. Create RG
    2. Deploy VM and it's dependencies
        * SKU -- F2s_v2 (CPU-2/RAM-4/IOPS-3200) or F4s_v2 (4/8/6400)
        * Acclerated Networking
        * NSG -- Allow Port 27015 (Incoming)
        * Dynamic IP and DNS
        * Auto shutdown at 1AM PST
    3. Deploy Storage Account -- queue.
    4. Deploy Function App

2. Provision VM with cloud-init script.
    1. Install LinuxGSM
    2. Install gamedig (Requires Node.JS)
    3. Install CSGO Server
    4. Setup cron jobs for monitor and run-at-boot
    5. Install LinuxGSM and CSGO config files (Requires Steam Auth token probably a manual step.)
