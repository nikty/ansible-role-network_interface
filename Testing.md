Testing is done via molecule.


```
TEST_PAUSE=1 TEST_CONFIGURED_ONLY=1 TEST_VERIFY_PLAYBOOK=tests/100_test_implicit_loopback_only.yaml  mol verify -s vagrant
```

## Environment variables

- `TEST_PAUSE`: whether to pause playbook (e.g. to manually inspect configuration after role is applied)
- `TEST_CONFIGURED_ONLY`: whether to set `network_configured_interfaces_only`
- `TEST_IMPLICIT_LOOPBACK`: whether to set `network_interface_implicit_loopback`
- `TEST_RESTART`: whether to restart interfaces
- `TEST_RESTART_REBOOT`: whether to reboot after network configuration is templated

- `TEST_VERIFY_PLAYBOOK`: run specified playbook instead of the default one