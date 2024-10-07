variable "database" {
  type = object({
    admin_password             = string
    backup_id                  = optional(string)
    backup_tde_password        = optional(string)
    character_set              = optional(string)
    database_id                = optional(string)
    database_software_image_id = optional(string)
    db_backup_config = optional(object({
      auto_backup_enabled     = optional(bool)
      auto_backup_window      = optional(string)
      auto_full_backup_day    = optional(string)
      auto_full_backup_window = optional(string)
      backup_deletion_policy  = optional(string)
      backup_destination_details = optional(object({
        dbrs_policy_id = optional(string)
        id             = optional(string)
        type           = optional(string)
      }))
      recovery_window_in_days   = optional(number)
      run_immediate_full_backup = optional(bool)
    }))
    db_name                               = optional(string)
    db_workload                           = optional(string)
    defined_tags                          = optional(map(string))    
    freeform_tags                         = optional(map(string))
    key_store_id                          = optional(string)
    kms_key_id                            = optional(string)
    kms_key_version_id                    = optional(string)
    ncharacter_set                        = optional(string)
    pdb_name                              = optional(string)
    pluggable_databases                   = optional(list(string))
    sid_prefix                            = optional(string)
    tde_wallet_password                   = optional(string)
    time_stamp_for_point_in_time_recovery = optional(string)
    vault_id                              = optional(string)
  })
  default = null
  sensitive = true
}

variable "database_software_image_id" {
  type    = string
  default = null
}

variable "db_system_id" {
  type    = string
  default = null
}

variable "db_version" {
  type    = string
  default = null
}

variable "defined_tags" {
  type    = map(string)
  default = null
}

variable "display_name" {
  type    = string
  default = null
}

variable "is_desupported_version" {
  type    = bool
  default = null
}

variable "is_unified_auditing_enabled" {
  type    = bool
  default = null
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "kms_key_version_id" {
  type    = string
  default = null
}

variable "freeform_tags" {
  type    = map(string)
  default = null
}

variable "dbsource" {
  type    = string
  default = null
}

variable "vm_cluster_id" {
  type    = string
  default = null
}

variable "groups" {
  type    = list(string)
  default = []
}

variable "compartment_id" {
  type = string
  default = null
}

variable "compartment" {
  type    = string
  default = null
}