variable("bucket",
  description: "The name of the bucket. If omitted, Terraform will assign a random, unique name.", # IE: terraform-2020052606510241590000000
  default:     nil,
)

variable("acl",
  description: "(Optional) The canned ACL to apply. Defaults to 'private'.",
  default:     "private",
)
