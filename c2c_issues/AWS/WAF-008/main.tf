# WAF-008: WAF Web ACL missing known bad inputs rule
# Misconfiguration: WebACL does NOT include AWSManagedRulesKnownBadInputsRuleSet

resource "aws_wafv2_web_acl" "waf008_no_bad_inputs_rule" {
  name  = "waf008-no-bad-inputs"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  # MISCONFIGURATION: no rules defined, specifically missing AWSManagedRulesKnownBadInputsRuleSet

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "waf008-no-bad-inputs"
    sampled_requests_enabled   = true
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
