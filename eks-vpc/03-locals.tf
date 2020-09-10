# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {

  map_users = [ 
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/tgaleev"
      username = "tgaleev"
      groups   = ["system:masters"]
    }
  ]

  map_roles = []

  map_accounts = []
}