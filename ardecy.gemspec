# frozen_string_literal: true

require_relative 'lib/ardecy/version'

# https://guides.rubygems.org/specification-reference/
Gem::Specification.new do |s|
  s.name = 'ardecy'
  s.summary = 'Ardecy is a security | privacy auditing tools.'
  s.version = Ardecy::VERSION
  s.platform = Gem::Platform::RUBY
  s.description = <<-DESCRIPTION
    Ardecy is a security, privacy auditing, fixing and hardening tool for GNU/Linux.
  DESCRIPTION
  s.email = 'szorfein@protonmail.com'
  s.files = Dir.glob('lib/**/*', File::FNM_DOTMATCH)
  s.homepage = 'https://github.com/szorfein/ardecy'
  s.license = 'MIT'
  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/szorfein/ardecy/issues',
    'changelog_uri' => 'https://github.com/szorfein/ardecy/blob/master/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/szorfein/ardecy',
    'wiki_uri' => 'https://github.com/szorfein/ardecy/wiki',
    'funding_uri' => 'https://patreon.com/szorfein',
  }
  s.author = 'szorfein'
  s.bindir = 'bin'
  s.cert_chain = ['certs/szorfein.pem']
  s.executables << 'ardecy'
  s.extra_rdoc_files = ['README.md']
  s.required_ruby_version = '>=2.6'
  s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $0 =~ /gem\z/
end

