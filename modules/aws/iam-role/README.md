# IAM role module

Creates an IAM role with a trust policy for explicitly supplied principal
ARNs. Optional managed policy attachments can be provided separately through
`managed_policy_arns`.

This module does not grant permissions by default. Trusting a user to assume a
role and granting that role permissions are separate decisions.
