# Ardecy

<div align="center">
<br/>

[![Gem Version](https://badge.fury.io/rb/ardecy.svg)](https://badge.fury.io/rb/ardecy)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

</div>

Ardecy is a security, privacy auditing, fixing and hardening tool for Linux.

## Install ardecy locally

With gem:

    gem cert --add <(curl -Ls https://raw.githubusercontent.com/szorfein/ardecy/master/certs/szorfein.pem)
    gem install ardecy -P HighSecurity
    ardecy -h

With github:

    git clone https://github.com/szorfein/ardecy
    cd ardecy
    ruby -I lib bin/ardecy -h

## Usage
Audit your system

    ardecy --audit

Correct errors found

    ardecy --fix
