Testing is done via molecule.


```
TEST_PAUSE=1 TEST_CONFIGURED_ONLY=1 TEST_VERIFY_PLAYBOOK=tests/100_test_implicit_loopback_only.yaml  mol verify -s vagrant
```

## Environment variables

- `TEST_PAUSE`: whether to pause playbook (e.g. to manually inspect configuration after role is applied)

- `TEST_CONFIGURED_ONLY`: set `network_interface_configured_only`

- `TEST_IMPLICIT_LOOPBACK`: set `network_interface_implicit_loopback`

- `TEST_RESTART`: whether to restart interfaces

- `TEST_RESTART_REBOOT`: whether to reboot after network configuration is templated

- `TEST_VERIFY_PLAYBOOK`: run specified playbook instead of the default one

- `TEST_SINGLE_CONFIG_FILE`: set `network_interface_single_configuration_file`

## Test harness

- molecule/shared/converge.yaml - restores original network config and create virtual test interfaces

- molecule/shared/create_virtual_interface.yaml - loop friendly

- tests/tasks/system_interface_control.yaml - Bring interface up or down via `ifup`, `ifdown` or similar system commands
  Vars:
    - state: up, down, restart
    - interface: interface name

- tests/tasks/test_interface_state.yaml - Test if link is up
  Vars:
    - interface: interface name
    - state: up, down

- tests/tasks/assert_interface_has_ip_address.yaml - Test if interface has specified IP address
  Vars:
    - iface: interface name
    - addresses: list of ip addresses

- tests/tasks/test_route.yaml - Test ip route
  Vars:
    - dst: address
    - gateway: gateway address
    - state: present (default), absent

- tests/helpers/manage_route.yaml - Add/remove routes
  Vars:
    - dst: IP Address
    - gateway: gateway address
    - state: present, absent

- tests/helpers/test_file_contents.yaml - Test file contents against regexp
  Vars:
    - file: file path
    - regexp: pattern to match