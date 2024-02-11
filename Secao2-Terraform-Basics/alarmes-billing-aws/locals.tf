
# Definição dos detalhes dos alarmes em um mapa
locals {
  billing_alarms = {
    "BillingAlarm1" = {
      threshold   = 1.0,
      description = "This alarm is triggered when estimated charges exceed $1."
    },
    "BillingAlarm2" = {
      threshold   = 3.0,
      description = "This alarm is triggered when estimated charges exceed $3."
    },
    "BillingAlarm3" = {
      threshold   = 5.0,
      description = "This alarm is triggered when estimated charges exceed $5."
    },
    "BillingAlarm4" = {
      threshold   = 10.0,
      description = "This alarm is triggered when estimated charges exceed $10."
    },
    "BillingAlarm5" = {
      threshold   = 20.0,
      description = "This alarm is triggered when estimated charges exceed $20."
    }
  }
}