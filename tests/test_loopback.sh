#!/bin/sh

set -e

playbooks="
tests/100_test_implicit_loopback.yaml
tests/101_test_explicit_loopback.yaml
"

#test -z "${TEST_PAUSE-}" && export TEST_PAUSE=

for p in $playbooks; do
    TEST_CONFIGURED_ONLY=1 TEST_IMPLICIT_LOOPBACK=1 TEST_VERIFY_PLAYBOOK="$p" mol verify -s vagrant
done

for p in $playbooks; do
    TEST_CONFIGURED_ONLY=1 TEST_IMPLICIT_LOOPBACK=0 TEST_VERIFY_PLAYBOOK="$p" mol verify -s vagrant
done

for p in $playbooks; do
    TEST_CONFIGURED_ONLY=0 TEST_IMPLICIT_LOOPBACK=0 TEST_VERIFY_PLAYBOOK="$p" mol verify -s vagrant
done
