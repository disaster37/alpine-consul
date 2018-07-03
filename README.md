alpine-consul
===============

This image permit to run Consul.



### Parameters

#### Confd

The Minio setting is managed by Confd. So you can custom it:
- **CONFD_BACKEND**: The Confd backend that you should use. Default is `env`.
- **CONFD_NODES**: The array of Confd URL to contact the backend. No default value.
- **CONFD_PREFIX_KEY**: The Confd prefix key. Default is `/gocd`


#### Consul

- **CONSUL_CONFIG_NODENAME**: The node name. Default is empty.
- **CONSUL_CONFIG_DATACENTER**: The datacenter name. Default is `default`.
- **CONSUL_CONFIG_CRYPTKEY**: The encrypt key (16-bit base-64 encoded string). You can generate it with consul keygen. No default value.
- **CONSUL_CONFIG_MASTERTOKEN**: The master token to access on Consul.
- **CONSUL_CONFIG_AGENTTOKEN**: The agent token.
- **CONSUL_CONFIG_LOGLEVEL**: The log level. Default to `INFO`.
- **CONSUL_CONFIG_HOSTS_X**: The list of servers to create cluster (3 or 5 servers). Default is empty.
- **CONSUL_CONFIG_EXPECTEDBOOTSTRAP**: The number of node to wait before start bootstrap.
