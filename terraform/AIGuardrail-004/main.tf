# AIGuardrail-004: Bedrock Guardrail prompt attack filter not HIGH
# Misconfiguration: PROMPT_ATTACK input_strength = "LOW" (should be "HIGH")

resource "aws_bedrock_guardrail" "aiguardrail004_weak_prompt_attack" {
  name                      = "aiguardrail004-weak-prompt"
  blocked_input_messaging   = "This content is blocked"
  blocked_outputs_messaging = "This output is blocked"
  description               = "Guardrail with LOW prompt attack strength - triggers AIGuardrail-004"

  content_policy_config {
    filters_config {
      # MISCONFIGURATION: input_strength is LOW instead of HIGH
      type            = "PROMPT_ATTACK"
      input_strength  = "LOW"
      output_strength = "NONE"
    }
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
