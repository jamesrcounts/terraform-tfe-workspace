output "id" {
  description = "The workspace id."
  value = tfe_workspace.ws.id
}

output "name" {
  description = "The workspace name."
  value = tfe_workspace.ws.name
}
