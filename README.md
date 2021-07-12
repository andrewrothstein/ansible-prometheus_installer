andrewrothstein.prometheus-installer
=========
![Build Status](https://github.com/andrewrothstein/ansible-prometheus-installer/actions/workflows/build.yml/badge.svg)

A base role for installing [Prometheus](https://prometheus.io/download/) related apps.

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.prometheus-installer
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
