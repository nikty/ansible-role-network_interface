# network_interface


_WARNING: This role can be dangerous to use. If you lose network connectivity
to your target host by incorrectly configuring your networking, you may be
unable to recover without physical access to the machine._

This roles enables users to configure various network components on target
machines. The role can be used to configure:

- Loopback interfaces
- Ethernet interfaces
- Bridge interfaces
- Bonded interfaces
- VLAN tagged interfaces

## Requirements


This role requires Ansible 2.9.16 or higher, and platform requirements are listed
in the metadata file.

## Role Variables


The variables that can be passed to this role and a brief description about
them are as follows:

```
network_interface:
  ethernets: []
  bonds: []
  vlans: []
  bridges: []
  loopbacks: []
```

Interface configuration.

`network_interface_implicit_loopback`

Whether to create configuration for loopback interface, see *Loopback interface configuration*.

`network_interface_file_prefix`

The prefix for interface configuration files. Default: `ifcfg-`.

`network_interface_file_postfix`

The postfix for interface configuration files. Default: ''.

`network_interface_restart`

Whether to restart interfaces.

`network_interface_single_configuration_file`

Where supported, whether to create single configuration file with all network settings, e.g. `/etc/network/interfaces` for *ifupdown*.

## TODO: Configuration backends

*Only Debian systems and ifupdown backend is supported so far.*

This role aims to be configuration backend-agnostic.

Variable `network_interface_configuration_backend` allows to force specific configuration backend.

Supported backends are:
- ifupdown (Debian, default)
- netplan
- rc (FreeBSD, default)
- systemd-networkd
- ifupdown2

## Loopback interface configuration

### Linux

Role assumes that for Linux there exists only one loopback interface "lo":

```
From .../drivers/net/loopback.c : /* The loopback device is special. There is only one instance per network namespace. */ ```
```

For Debians, default configuration for "lo" is created, unless `network_interface_implicit_loopback` is false:
```
auto lo
iface lo inet loopback
```

If additional configuration of loopback interface is necessary, set it in `network_loopback_interfaces`:
```
network_interface:
  loopbacks:
  - device: lo
    addresses:
      - 1.2.3.4
    backend:
      ifupdown:
        command_options:
          - /bin/true
```

TODO: additional loopback-like devices via "dummy" driver.

## Examples

### Ethernets
```
network_interface:
  ethernets:
  # Static IPv4 and IPv6
  - device: eth0
    addresses:
      - 192.0.2.2/24
      - 192.0.2.3/24
      - 2001:db8::2/64
    gateway4: 192.0.2.1 # set to "auto" to configure first address in subnet as gateway
    gateway6: 2001:db8::1
    backend:
      ifupdown:
        command_options:
        - "up /execute/this"
        - "down /execute/that"
    description: 'Ethernet 0"

  # DHCPv4
  - device: eth1
    dhcpv4: yes

```

### VLANs

Vlans can have arbitrary name:
```
network_interface:
  vlans:
  - device: vlan10
    link: eth1
    id: 10
```

On Debians it's enough to set the vlan device name, and interface will be created based on the name (see **VLAN INTERFACES** in `man interfaces`):
```
network_interface:
  vlans:
  - device: eth1.10
```

### Bonds

```
network_interface:
  bonds:
  - device: bond0
    interfaces:
      - eth0
      - eth1
    parameters:
      mode: 802.3ad
      mii-monitor-interval: 1
```

## Dependencies

`python-netaddr`

## License

BSD

## Author Information

This project was originally created by [Benno Joy](https://github.com/bennojoy/network_interface).

Debian upgrades by:

* Martin Verges (croit, GmbH)
* Eric Anderson (Avi Networks, Inc.)

RedHat upgrades by:

* Eric Anderson (Avi Networks, Inc.)
* Luke Short (Red Hat, Inc.)
* Wei Tie, (Cisco Systems, Inc.)

The full list of contributors can be found [here](https://github.com/MartinVerges/ansible.network_interface/graphs/contributors).
