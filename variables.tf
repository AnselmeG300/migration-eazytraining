variable "aws_common_tag" {
  description = "Specifies object tags key and value."
  type        = map(string)
  default     = {}
}

variable "size" {
  type    = number
  default = 100
}

variable "maintainer" {
  description = "Specifies object tags key and value."
  type        = string
  default     = "eazytraining"
}

variable "ssh_key" {
  type    = string
  default = "eazytraining-migration"
}


variable "user" {
  type    = string
  default = "centos"
}

variable "elb_ssl_cert" {
  type    = string
  default = ""
}

#--------------------------------------------------------
### Database
variable "rds_instance_type" {
  description = "(Required) The instance type of the RDS instance."
  type        = string
  default     = "db.t2.micro"
}


variable "db_password" {
  description = "DO NOT CHANGE - Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
  default     = "dbpass1234567"
  type        = string
}

variable "tags" {
  description = "Specifies object tags key and value."
  type        = map(string)
  default     = {}
}

variable "db_name" {
  description = "DO NOT CHANGE - Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
  default     = "dbw"
  type        = string
}

variable "db_username" {
  description = "DO NOT CHANGE - Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
  default     = "dbwuser"
  type        = string
}

variable "min_size" {
  type        = number
  default     = 0
}

variable "max_size" {
  type        = number
  default     = 1
}

variable "instance_type" {
  type        = string
  default     = "t2.large"
}

variable "ami" {
  description = "Specifies object tags key and value."
  type        = map(string)
  default     = {
    "us-east-1": "ami-0c7217cdde317cfec"
    "eu-west-1": "ami-0c1f3a8058fde8814",
    "eu-west-3": "ami-0430199e358bd917d",
  }
}


variable "AZ" {
  type    = map(string)
  default = {
    "us-east-1": "us-east-1b",
    "eu-west-3": "eu-west-3b",
    "eu-west-1": "eu-west-1b",
  }
}

variable "region" {
  type = string
  default = "eu-west-1"
}

variable "cloudfront_id" {
  type = string
  default = "E3L5T4YR5R26Z9"
}

variable "snapshot_id" {
  type = string
  default = "snap-016ec0b440dc73e99"
}
