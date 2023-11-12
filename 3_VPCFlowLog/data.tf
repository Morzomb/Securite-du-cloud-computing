# data.tf

# Données de modèle pour le script utilisateur SSM Agent
data "template_file" "ssm_agent_sh" {
  template = file("user_data.sh")
  vars = {
    message = "ssm_agent_sh"
  }
}
