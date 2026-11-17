require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require 'open3'

class JiraMcpTest < Minitest::Test
  SCRIPT = File.expand_path('../scripts/jira-mcp.rb', __dir__)

  def run_launcher(env_text)
    Dir.mktmpdir do |dir|
      FileUtils.mkdir_p(File.join(dir, 'scripts'))
      FileUtils.cp(SCRIPT, File.join(dir, 'scripts', 'jira-mcp.rb'))
      File.write(File.join(dir, '.env'), env_text) if env_text
      File.write(File.join(dir, 'uvx'), <<~SH)
        #!/bin/sh
        [ "$READ_ONLY_MODE" = true ] || exit 6
        [ "$JIRA_URL" = https://test.atlassian.net ] || exit 7
        [ "$JIRA_USERNAME" = test@example.com ] || exit 8
        [ "$JIRA_API_TOKEN" = test-token ] || exit 9
        [ "$1" = mcp-atlassian@0.24.0 ] || exit 10
        printf 'mock listo\n'
      SH
      File.chmod(0o700, File.join(dir, 'uvx'))
      Open3.capture3({ 'PATH' => "#{dir}:#{ENV.fetch('PATH')}" }, RbConfig.ruby, File.join(dir, 'scripts', 'jira-mcp.rb'))
    end
  end

  def valid_env
    "JIRA_URL=https://test.atlassian.net\nJIRA_USERNAME=test@example.com\nJIRA_API_TOKEN='test-token'\n"
  end

  def test_arranca_con_lectura_y_datos_ficticios
    out, err, status = run_launcher(valid_env)
    assert status.success?, err
    assert_equal "mock listo\n", out
    assert_equal '', err
  end

  def test_bloquea_claves_duplicadas_sin_mostrar_token
    out, err, status = run_launcher(valid_env + "JIRA_API_TOKEN=otro-secreto\n")
    refute status.success?
    assert_includes err, 'variable duplicada'
    refute_includes out + err, 'otro-secreto'
  end

  def test_rechaza_destino_externo
    _out, err, status = run_launcher(valid_env.sub('test.atlassian.net', 'example.com'))
    refute status.success?
    assert_includes err, 'Jira Cloud'
  end

  def test_informa_campo_ausente
    _out, err, status = run_launcher("JIRA_URL=https://test.atlassian.net\n")
    refute status.success?
    assert_includes err, 'JIRA_API_TOKEN'
  end
end