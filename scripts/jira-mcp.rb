#!/usr/bin/env ruby
# Lanzador MCP: no ejecutar el archivo de entorno como código ni imprimir secretos.
require 'uri'

required = %w[JIRA_URL JIRA_USERNAME JIRA_API_TOKEN].freeze
path = File.expand_path('../.env', __dir__)
values = {}

begin
  File.foreach(path) do |line|
    match = line.match(/\A\s*(JIRA_URL|JIRA_USERNAME|JIRA_API_TOKEN)\s*=\s*(.*?)\s*\z/)
    next unless match

    key, value = match.captures
    abort "Jira MCP: variable duplicada: #{key}" if values.key?(key)
    if value.start_with?("'", '"')
      abort "Jira MCP: comillas inválidas para #{key}" unless value.length >= 2 && value[-1] == value[0]
      value = value[1...-1]
    end
    abort "Jira MCP: valor inválido para #{key}" if value.empty? || value.match?(/[\r\n]/) || value.include?('REEMPLAZAR_')
    values[key] = value
  end
rescue Errno::ENOENT, Errno::EACCES
  abort 'Jira MCP: archivo local de credenciales ausente o inaccesible; consulta docs/jira-copilot-claude.md.'
end

missing = required.reject { |key| values.key?(key) }
abort "Jira MCP: faltan variables: #{missing.join(', ')}" unless missing.empty?
begin
  url = URI.parse(values.fetch('JIRA_URL'))
  valid = url.is_a?(URI::HTTPS) && url.host && url.host.end_with?('.atlassian.net') && !url.userinfo && !url.query && !url.fragment && (url.path.empty? || url.path == '/')
  abort 'Jira MCP: JIRA_URL debe ser el origen HTTPS de un sitio Jira Cloud atlassian.net.' unless valid
rescue URI::InvalidURIError
  abort 'Jira MCP: JIRA_URL no es una URL válida.'
end

required.each { |key| ENV[key] = values.fetch(key) }
ENV['READ_ONLY_MODE'] = 'true'
begin
  exec('uvx', 'mcp-atlassian@0.24.0')
rescue Errno::ENOENT
  abort 'Jira MCP: uvx no está disponible en el PATH del cliente; consulta docs/jira-copilot-claude.md.'
end