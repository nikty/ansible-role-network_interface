# Testing

Testing is done via molecule.

To run all tests execute:
```
molecule verify
```

To run single test set `TEST_VERIFY_PLAYBOOK` variable:
```
TEST_VERIFY_PLAYBOOK=tests/001_test_ethernet_ipv4_static.yaml  molecule verify
```

## Environment variables

Several environment variables can be used to control tests.

- `TEST_PAUSE`: whether to run pause tasks in tests (for example, to manually inspect system state at a certain point)

- `TEST_IMPLICIT_LOOPBACK`: whether to configure loopback device if it's not explicitly mentioned in configuration (sets `network_interface_implicit_loopback`)

- `TEST_RESTART`: whether to restart interfaces (sets `network_interface_restart`)

- `TEST_SINGLE_CONFIG_FILE`: set `network_interface_single_configuration_file`

Environment variables for molecule:

- `TEST_VERIFY_PLAYBOOK`: run specified playbook instead of the default one


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

- tests/helpers/flush_handlers.yaml - Flush handlers

- tests/helpers/debug_pause.yaml - Pause task, respects environment variable `TEST_PAUSE`.

- tests/helpers/compare_lines.yaml - Compare text line by line

Vars:
    - compare_lines_from: string
    - compare_lines_from_file: path to remote file
    - compare_lines_to: string
    - compare_lines_to_file: path to remote file
    - compare_lines_ignore_blank_lines: boolean - whether blank lines matter. Default: **true**
    - compare_lines_trim_whitespace: boolean - ignore whitespace at the beginning and ending of lines. Default: **true**

