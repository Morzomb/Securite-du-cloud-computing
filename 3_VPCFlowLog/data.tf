data "template_file" "ssm_agent_sh" {
  template = file("user_data.sh")
  vars = {
    message = "ssm_agent_sh"
  }
}