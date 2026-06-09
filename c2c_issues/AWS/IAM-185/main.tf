# IAM-185: Resource policy allows all actions for all principals
# Misconfiguration: policy document grants * actions to * principals without conditions

data "aws_iam_policy_document" "iam185_overly_permissive" {
  statement {
    effect = "Allow"
    # MISCONFIGURATION: all principals, all actions, no conditions
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["*"]
    resources = ["*"]
  }
}

# Attach to an SQS queue to make it a deployable resource
resource "aws_sqs_queue" "iam185_test_queue" {
  name = "iam185-overly-permissive-queue"

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_sqs_queue_policy" "iam185_queue_policy" {
  queue_url = aws_sqs_queue.iam185_test_queue.id
  policy    = data.aws_iam_policy_document.iam185_overly_permissive.json
}
