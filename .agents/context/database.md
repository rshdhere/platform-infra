# State and persistence

Terraform state bootstrap belongs in cms/bootstrap/terraform-state/. Application data belongs to the proposed Aurora cluster documented in cms/modules/aws/database/README.md. Review backup, restore and replacement impact when changing database infrastructure. Application schema migrations belong with the application.
