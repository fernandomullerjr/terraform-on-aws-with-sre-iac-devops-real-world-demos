
# Este arquivo outputs.tf irá gerar uma saída chamada billing_alarm_details que contém um mapa com os detalhes de cada alarme de faturamento, incluindo o nome do alarme, o limite, a descrição e o ARN.
output "billing_alarm_details" {
  value = {
    for alarm_name, alarm_details in aws_cloudwatch_metric_alarm.billing_alarms :
    alarm_name => {
      threshold = alarm_details.threshold,
      #      description       = alarm_details.description,             #### ESTE NÃO É SUPORTADO:  Error: Unsupported attribute , │ This object does not have an attribute named "description".
      alarm_arn = alarm_details.arn
    }
  }
  description = "Detalhes dos alarmes de faturamento criados."
}

output "billing_alert_topic_arn" {
  value       = aws_sns_topic.billing_alert_topic.arn
  description = "ARN do tópico SNS para alertas de faturamento."
}

output "email_subscription_endpoint" {
  value       = aws_sns_topic_subscription.email_subscription.endpoint
  description = "Endereço de email para inscrição em notificações de faturamento."
}


output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
