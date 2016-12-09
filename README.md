Cloud Farmer is a set of simple tools to deploy Server Farmer on new cloud instance
in unattended mode (without user interaction during the whole setup).

Currently it supports:

- Amazon EC2
- Beyond e24cloud.com
- Google Compute Engine
- Microsoft Azure
- Rackspace Cloud
- any cloud service based on OpenStack (including public, private and hybrid clouds)

All supported providers are well tested with Ubuntu 14.04 LTS and 16.04 LTS, and also
are expected to work without major problems with any recent Debian or Ubuntu version).


## Example usage

### Installation

Cloud Farmer requires Server Farmer installed and configured at least as farm manager,
preferably also as backup collector.

```
git clone https://github.com/serverfarmer/cloudfarmer /opt/cloud
```

Now edit files in /opt/cloud/credentials directory.

### Creating new cloud instance

```
/opt/cloud/create.sh ec2 test_key1 m4.xlarge
```

```
/opt/cloud/create.sh azure testkey2 Standard_A2
```

```
/opt/cloud/create.sh rackspace test_key3 compute1-60
```

```
/opt/cloud/create.sh e24cloud testkey4 m1.small
```

```
/opt/cloud/create.sh gce testkey5 n1-highcpu-2
```

### Provisioning new cloud instance

```
/opt/cloud/deploy.sh ec2-54-123-45-67.compute-1.amazonaws.com /etc/local/.ssh/id_ec2_test_key1
```

```
/opt/cloud/deploy.sh testkey2-5c82.eastus.cloudapp.azure.com /etc/local/.ssh/id_azure_testkey2
```

```
/opt/cloud/deploy.sh 162.209.99.47 /etc/local/.ssh/id_rack_test_key3
```

```
/opt/cloud/deploy.sh ip-178-216-203-155.e24cloud.com /etc/local/.ssh/id_rack_testkey4
```

```
/opt/cloud/deploy.sh 204.111.199.104.bc.googleusercontent.com /etc/local/.ssh/id_gce_testkey5
```

## Customization

All user-related data are contained inside /opt/cloud/credentials directory.


## External dependencies

If you only want to work with already created cloud instances, Cloud Farmer is enough.
However, Cloud Farmer provides also the simple, unified interface for creating new
cloud instances, with just 1 command.

This functionality is currently supported for Amazon EC2, Microsoft Azure and Rackspace
Cloud services.

### Amazon EC2

Creating new Amazon EC2 instances requires "awscli" AWS command line client:

```
apt-get install python-pip
pip install awscli
aws configure
```

### Beyond e24cloud.com

Creating new e24cloud instances requires Amazon PHP SDK 1.6.2 (1.x latest) installed:

```
cd /usr/share/php
wget http://pear.amazonwebservices.com/get/sdk-latest.zip
unzip -b sdk-latest.zip
```

### Google Compute Engine

Creating new GCE instances requires Google Cloud SDK installed:

```
curl https://sdk.cloud.google.com |bash
exec -l $SHELL
gcloud init
```

### Microsoft Azure

Creating new Microsoft Azure instances requires "azure" AWS command line client:

```
curl -sL https://deb.nodesource.com/setup_6.x |bash
apt-get install -y nodejs
npm install -g azure-cli
azure login
```

### Rackspace Cloud

Creating new Rackspace Cloud instances requires "rack" command line client:

```
wget -O /usr/local/bin/rack https://ec4a542dbf90c03b9f75-b342aba65414ad802720b41e8159cf45.ssl.cf5.rackcdn.com/1.2/Linux/amd64/rack
chmod +x /usr/local/bin/rack
rack configure
```

Note that the configuration process will ask you for a Profile Name. Cloud Farmer
works only with named profiles, not with the default nameless profile.
