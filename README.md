Install MongoS
=========

This role installs mongos and its tools from APT, creates the `mongodb` system user,
`/etc/mongosh.conf`, a consul health check helper and a systemd timer that keeps the
mongosh history in reverse order.

[![Build Status](https://github.com/Rheinwerk/ansible-role-mongos/actions/workflows/ci.yml/badge.svg)](https://github.com/Rheinwerk/ansible-role-mongos/actions/workflows/ci.yml)

Requirements
------------

None.

Role Variables
--------------

`meta/argument_specs.yml` and `tasks/assert.yml` check the values before anything is
installed; a wrong type, an unknown key or the `_mongos` dict of v1.x fails the run at
the start. The play sets the repository and the packages together, so the role has no
default for them.

| Variable | Default | Description |
| --- | --- | --- |
| `_mongos_deb822_repository` | `[]` | APT repositories: `name`, `uris` (http or https), `suites`, `components` and `signed_by` (key URL or absolute keyring path) are required; `types` is always `deb`. |
| `_mongos_apt` | `packages: []` | `packages` lists at least one `{name, version}`, installed as `<name>=<version>`; `version` is an APT pattern such as `8.0*` or `*`. |

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      vars:
        _mongos_deb822_repository:
          - name: mongodb_jammy
            uris: https://repo.mongodb.org/apt/ubuntu
            suites: jammy/mongodb-org/8.0
            components: multiverse
            signed_by: https://www.mongodb.org/static/pgp/server-8.0.asc
        _mongos_apt:
          packages:
            - { name: mongodb-org-mongos, version: "8.0*" }
      roles:
        - { role: mongos, tags: ['mongos'] }

License
-------

Please see LICENSE.

Author Information
------------------

Original author is [Daniel Schneller](https://github.com/dschneller) as member of the [Rheinwerk](https://github.com/Rheinwerk) project.
