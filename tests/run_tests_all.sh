#!/bin/sh
set -e

export PY_COLORS=1 # colored molecule output

_playbooks="
test_ethernet_empty.yaml
test_ethernet_ifupdown_selection_override.yaml
test_ethernet_command_options_only.yaml
test_ethernet_ipv4_auto_gateway.yaml
test_ethernet_ipv4_static.yaml
test_ethernet_ipv4_static_multiple_addresses.yaml
test_ethernet_ipv4_static_multiple_addresses_with_options.yaml
test_ethernet_ipv4_static_with_options.yaml
test_ethernet_ipv4_static_and_dhcp.yaml
test_ethernet_ipv6_static.yaml
test_ethernet_ipv6_static_multiple_addresses.yaml
test_ethernet_ipv4_and_ipv6_static.yaml  
test_loopback_implicit.yaml
test_loopback_explicit.yaml
test_vlan_no_ip.yaml
"

playbooks=$(echo "$playbooks" | sed '/^#/d')

for p in $playbooks; do
    molecule converge
    printf "
################################################################
Running playbook: $p
################################################################
"
    TEST_VERIFY_PLAYBOOK="tests/$p" molecule verify
done
