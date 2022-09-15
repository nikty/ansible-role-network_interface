#!/bin/sh
export PY_COLORS=1 # colored molecule output

playbooks="
001_test_ethernet_ipv4_static.yaml
002_test_ethernet_ipv4_auto_gateway.yaml
003_test_ethernet_ipv4_static_multiple_addresses.yaml
004_test_ethernet_ipv4_static_with_options.yaml
005_test_ethernet_manual_debian_options.yaml
006_test_ethernet_ipv6_static.yaml
007_test_loopback_interface_no_options.yaml
008_test_loopback_interface_ipv4_static.yaml
"

for p in $playbooks; do
    TEST_VERIFY_PLAYBOOK=tests/"$p" mol verify -s vagrant
done
