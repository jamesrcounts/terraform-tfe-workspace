output "name" {
  value = tfe_workspace.ws.name
}

output "oauth_client_id" {
  value = tfe_oauth_client.github.id
}