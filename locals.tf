locals {
  default_tags = {
    "IT.resource" : "database"
    "IT.deployedby" : "Terraform"
    "IT.provider" : "oci"
    "IT.create_date" : formatdate("DD/MM/YY hh:mm", timeadd(timestamp(), "-3h"))
  }
  defined_tags = merge(local.default_tags, var.defined_tags)
  database = {
    admin_password                        = var.database.admin_password
    backup_id                             = nonsensitive(lookup(var.database,"backup_id", null))
    backup_tde_password                   = lookup(var.database,"backup_tde_password", null)
    character_set                         = nonsensitive(lookup(var.database,"character_set", null))
    database_id                           = nonsensitive(lookup(var.database,"database_id", null))
    database_software_image_id            = nonsensitive(lookup(var.database,"database_software_image_id", null))
    db_backup_config                      = nonsensitive(lookup(var.database,"db_backup_config", null))
    db_name                               = nonsensitive(lookup(var.database,"db_name", null))
    db_workload                           = nonsensitive(lookup(var.database,"db_workload", null))
    defined_tags                          = nonsensitive(lookup(var.database,"defined_tags", null))
    enable_database_delete                = nonsensitive(lookup(var.database,"enable_database_delete", null))
    freeform_tags                         = nonsensitive(lookup(var.database,"freeform_tags", null))
    key_store_id                          = nonsensitive(lookup(var.database,"key_store_id", null))
    kms_key_id                            = nonsensitive(lookup(var.database,"kms_key_id", null))
    kms_key_version_id                    = nonsensitive(lookup(var.database,"kms_key_version_id", null))
    ncharacter_set                        = nonsensitive(lookup(var.database,"ncharacter_set", null))
    pdb_name                              = nonsensitive(lookup(var.database,"pdb_name", null))
    pluggable_databases                   = nonsensitive(lookup(var.database,"pluggable_databases", null))
    sid_prefix                            = nonsensitive(lookup(var.database,"sid_prefix", null))
    tde_wallet_password                   = lookup(var.database,"tde_wallet_password", null)
    time_stamp_for_point_in_time_recovery = nonsensitive(lookup(var.database,"time_stamp_for_point_in_time_recovery", null))
    vault_id                              = nonsensitive(lookup(var.database,"vault_id", null))
  }
}