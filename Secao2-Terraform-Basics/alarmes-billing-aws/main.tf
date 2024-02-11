
# Criação dos alarmes de faturamento usando um bloco for_each
resource "aws_cloudwatch_metric_alarm" "billing_alarms" {

  for_each = local.billing_alarms

  alarm_name          = each.key
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600" # Verificação a cada 6 horas
  statistic           = "Maximum"
  threshold           = each.value["threshold"]
  alarm_description   = each.value["description"]
  actions_enabled     = true

  alarm_actions = [aws_sns_topic.billing_alert_topic.arn] # ARN do tópico SNS para notificações
}

# Definição do tópico SNS para receber notificações
resource "aws_sns_topic" "billing_alert_topic" {
  name = "MyBillingAlertTopic"
}

# Inscrição no tópico SNS para receber notificações por email
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.billing_alert_topic.arn
  protocol  = "email"
  endpoint  = "fernandomj90@gmail.com" # Substitua pelo seu endereço de email
}

data "aws_caller_identity" "current" {}