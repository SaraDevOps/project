terraform {
    backend "s3" {
        bucket = "three-tier-3-tier-sara-2025"
        key    = "state/terraform.tfstate"
        region     = "us-east-2"
        #dynamodb_table = "dynamodb-state-locking"
    }
}