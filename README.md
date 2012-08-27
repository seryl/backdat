# backdat (shell)

A better backup library and service. Shell Command.

## Installation

    bash < <( curl -sL https://raw.github.com/seryl/backdat/shell/scripts/install-backdat)

## Usage

This branch holds a wrapper around duplicity to allow Amazon AWS S3 backups.

Using:

    backdat SOURCE
    backdat [ backup|restore] SOURCE
    backdat [ backup|restore] SOURCE TARGET

    ex: backdat my_directory my_prefix/my_tag

The application itself will handle all of the dependency installation, etc.
