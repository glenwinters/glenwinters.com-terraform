terraform {
  backend "remote" {
    organization = "glenwinters"

    workspaces {
      prefix = "glenwinterscom-"
    }
  }
}
