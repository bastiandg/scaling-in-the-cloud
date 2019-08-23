# Scaling Talk

## Variable setup

```sh
cp env.sh.example env.sh
editor env.sh # change project_id and credentials location
. env.sh
```

## Packer

- create packer service account
- set compute instance admin or compute admin on account
- create credentials file for account
- `cd packer && packer build image.json`
