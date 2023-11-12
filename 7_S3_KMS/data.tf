# data.tf

# Récupération du contenu d'un fichier de modèle et des informations d'identité de l'appelant AWS

data "template_file" "ssm_agent_sh" {
  template = file("user_data.sh")
  vars = {
    message = "ssm_agent_sh"
  }
}

data "aws_caller_identity" "current" {}
