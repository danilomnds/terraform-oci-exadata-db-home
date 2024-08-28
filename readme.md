# Module - Oracle Exadata Database DB Home
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![OCI](https://img.shields.io/badge/provider-OCI-red)](https://registry.terraform.io/providers/oracle/oci/latest)

Module developed to standardize the creation of Oracle Exadata Database DB Home.

## Compatibility Matrix

| Module Version | Terraform Version | OCI Version     |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.9.5            | 6.8.0           |

## Specifying a version

To avoid that your code get the latest module version, you can define the `?ref=***` in the URL to point to a specific version.
Note: The `?ref=***` refers a tag on the git module repo.

## Default use case
```hcl
module "DBHOME_<database name>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-exadata-db-home?ref=v1.0.0"
  database = {
    admin_password = "password"
    db_name        = "db name"
    character_set  = "the default is AL32UTF8. Another popular option is WE8ISO8859P15"
    ncharacter_set = "the default is AL16UTF16"
    db_workload    = "OLTP"
    db_backup_config = {
      auto_backup_enabled = true
    }
  }
  source       = "VM_CLUSTER_NEW"
  db_version   = "19c"
  display_name = "DBHOME_DBNAME"
}
output "display-name" {
  value = module.DBHOME_<database name>.name
}
output "exadata-id" {
  value = module.DBHOME_<database name>.id
}
```

## Default use case plus RBAC
```hcl
module "DBHOME_<database name>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-exadata-db-home?ref=v1.0.0"
  database = {
    admin_password = "password"
    db_name        = "db name"
    character_set  = "the default is AL32UTF8. Another popular option is WE8ISO8859P15"
    ncharacter_set = "the default is AL16UTF16"
    db_workload    = "OLTP"
    db_backup_config = {
      auto_backup_enabled = true
    }
  }
  source       = "VM_CLUSTER_NEW"
  db_version   = "19c"
  display_name = "DBHOME_DBNAME"
  compartment = <compartment name>
  # GRP_OCI_APP-ENV is the Azure AD group that you are going to grant the permissions
  groups = ["OracleIdentityCloudService/GRP_OCI_APP-ENV", "group name 2"]
}
output "display-name" {
  value = module.DBHOME_<database name>.name
}
output "exadata-id" {
  value = module.DBHOME_<database name>.id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database | Please check all options for the database map [here](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_db_home) | `object({})` | n/a | No |
| database_software_image_id | The database software image OCID | `string` | n/a | No |
| db_system_id | (Required when source=DATABASE | DB_BACKUP | NONE) The OCID of the DB system | `string` | n/a | No |
| db_version | (Applicable when source=NONE | VM_CLUSTER_NEW) A valid Oracle Database version | `string` | n/a | No |
| defined_tags | Defined tags for this resource | `map(string)` | n/a | No |
| display_name | the user-friendly name for the cloud exadata infrastructure resource | `string` | n/a | No |
| is_desupported_version | If true, the customer acknowledges that the specified Oracle Database software is an older release that is not currently supported by OCI | `bool` | n/a | No |
| is_unified_auditing_enabled | Indicates whether unified autiding is enabled or not | `bool` | n/a | No |
| kms_key_id | The OCID of the key container that is used as the master encryption key in database transparent data encryption (TDE) operations | `string` | n/a | No |
| kms_key_version_id | The OCID of the key container version that is used in database transparent data encryption (TDE) operations KMS Key can have multiple key versions | `string` | n/a | No |
| freeform_tags | Free-form tags for this resource | `map(string)` | n/a | No |
| source | The source of database: NONE for creating a new database. DB_BACKUP for creating a new database by restoring from a database backup. VM_CLUSTER_NEW for creating a database for VM Cluster | `string` | n/a | No |
| vm_cluster_id | (Required when source=VM_CLUSTER_BACKUP | VM_CLUSTER_NEW) The OCID of the VM cluster | `string` | n/a | No |
| groups | list of azure AD groups that will manage objects inside the bucket | `list(string)` | n/a | No |
| compartment_id | the ocid of the compartment. It should be specified if you are going to create an access policy | `string` | n/a | No |
| compartment | compartment name that will be used for policy creation | `string` | n/a | No |
| enable_group_access | enables the policy creation. If true the groups var should have a least one value | `bool` | `true` | No |

# Object variables for blocks

| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| database | admin_password | A strong password for SYS, SYSTEM, PDB Admin and TDE Wallet  | `sensitive(string)` | n/a | No |

## Output variables

| Name | Description |
|------|-------------|
| name | db home name|
| id | db home id |

## Documentation
Oracle Exadata Database DB Home: <br>
[https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_db_home](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_db_home)