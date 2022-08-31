# Template hierarchy

## Debian - ifupdown

* ifupdown_interface_base.j2 - Parent template for all interfaces

    * interface_ethernet_Debian.j2

    * interface_bond_Debian.j2
    
* ifupdown_macros.j2 - Macros

* ifupdown_ipv4_options.j2 - Includable options for IPv4 family

* ifupdown_ipv6_options.j2 - Includable options for IPv6 family

* _debian_bond.j2 - Includable options for bond interfaces
