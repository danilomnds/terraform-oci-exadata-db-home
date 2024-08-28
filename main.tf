resource "oci_database_db_home" "exadata_db_home" {
  dynamic "database" {
    for_each = local.database != null ? [local.database] : []
    content {
      admin_password             = database.value.admin_password
      backup_id                  = lookup(database.value, "backup_id", null)
      backup_tde_password        = lookup(database.value, "backup_tde_password", null)
      character_set              = lookup(database.value, "character_set", "AL32UTF8")
      database_id                = lookup(database.value, "database_id", null)
      database_software_image_id = lookup(database.value, "database_software_image_id", null)
      dynamic "db_backup_config" {
        for_each = database.value.db_backup_config != null ? [database.value.db_backup_config] : []
        content {
          auto_backup_enabled     = lookup(db_backup_config.value, "auto_backup_enabled", null)
          auto_backup_window      = lookup(db_backup_config.value, "auto_backup_window", null)
          auto_full_backup_day    = lookup(db_backup_config.value, "auto_full_backup_day", "Sunday")
          auto_full_backup_window = lookup(db_backup_config.value, "auto_full_backup_window", null)
          backup_deletion_policy  = lookup(db_backup_config.value, "backup_deletion_policy", null)
          dynamic "backup_destination_details" {
            for_each = db_backup_config.value.backup_destination_details != null ? [db_backup_config.value.backup_destination_details] : []
            content {
              dbrs_policy_id = lookup(backup_destination_details.value, "dbrs_policy_id", null)
              id             = lookup(backup_destination_details.value, "id", null)
              type           = lookup(backup_destination_details.value, "type", null)
            }
          }
          recovery_window_in_days   = lookup(db_backup_config.value, "recovery_window_in_days", null)
          run_immediate_full_backup = lookup(db_backup_config.value, "run_immediate_full_backup", null)
        }
      }
      db_name                               = lookup(database.value, "db_name", null)
      db_workload                           = lookup(database.value, "db_workload", null)
      defined_tags                          = lookup(database.value, "defined_tags", null)      
      freeform_tags                         = lookup(database.value, "freeform_tags", null)
      key_store_id                          = lookup(database.value, "key_store_id", null)
      kms_key_id                            = lookup(database.value, "kms_key_id", null)
      kms_key_version_id                    = lookup(database.value, "kms_key_version_id", null)
      ncharacter_set                        = lookup(database.value, "ncharacter_set", "AL16UTF16")
      pdb_name                              = lookup(database.value, "pdb_name", null)
      pluggable_databases                   = lookup(database.value, "pluggable_databases", null)
      sid_prefix                            = lookup(database.value, "sid_prefix", null)
      tde_wallet_password                   = lookup(database.value, "tde_wallet_password", null)
      time_stamp_for_point_in_time_recovery = lookup(database.value, "time_stamp_for_point_in_time_recovery", null)
      vault_id                              = lookup(database.value, "vault_id", null)
    }
  }
  database_software_image_id  = var.database_software_image_id
  db_system_id                = var.db_system_id
  db_version                  = var.db_version
  defined_tags                = local.defined_tags
  display_name                = var.display_name
  is_desupported_version      = var.is_desupported_version
  is_unified_auditing_enabled = var.is_unified_auditing_enabled
  kms_key_id                  = var.kms_key_id
  kms_key_version_id          = var.kms_key_version_id
  freeform_tags               = var.freeform_tags
  source                      = var.dbsource
  vm_cluster_id               = var.vm_cluster_id
  lifecycle {
    ignore_changes = [
      defined_tags["IT.create_date"]
    ]
  }
  timeouts {
    create = "12h"
    delete = "6h"
  }
}

resource "oci_identity_policy" "exadata_db_home_policy" {
  #if you are deploying the resource outside your home region uncomment the line below
  #provider   = oci.oci-gru
  depends_on = [oci_database_db_home.exadata_db_home]
  for_each = {
    for group in var.groups : group => group
    if var.enable_group_access && var.groups != [] && var.compartment != null
  }
  compartment_id = var.compartment_id
  name           = "policy_${var.display_name}"
  description    = "allow one or more groups to read the exadata db home"
  statements = [
    "Allow group ${each.value} to read db-homes in compartment ${var.compartment}",
    "Allow group ${each.value} to read databases in compartment ${var.compartment}"
  ]
}