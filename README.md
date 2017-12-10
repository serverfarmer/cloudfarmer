Cloud Farmer is a set of simple tools to deploy Server Farmer on new cloud instance
in unattended mode (without user interaction during the whole setup).

It supports:

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
/opt/cloud/setup.sh yourprovider
```

where `yourprovider` is one of: `azure`, `e24cloud`, `ec2`, `gce` or `rackspace`. The
second command will install any required external dependencies for given provider.

Note that for some providers (mainly `azure` & `gce`) it may need manual attention,
including browser interaction, while for others (eg. `ec2`) you have to run the
account setup separately.

For `rackspace` provider, the configuration process will ask you for a Profile Name.
Cloud Farmer works only with named profiles, not with the default nameless profile, so
you have to type some non-empty name there, even if you use only one Rackspace account.

After you finished the initial setup, edit files in `/opt/cloud/credentials` directory
and make sure that your provider is properly configured.

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

### Installing Server Farmer on new cloud instance

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

## How to contribute

We are welcome to contributions of any kind: bug fixes, added code comments,
support for new operating system versions, cloud platforms etc.

If you want to contribute:
- fork this repository and clone it to your machine
- create a feature branch and do the change inside it
- push your feature branch to github and create a pull request

## License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Tomasz Klim (<opensource@tomaszklim.pl>) |
| **Copyright:**       | Copyright 2015-2017 Tomasz Klim          |
| **License:**         | MIT                                      |

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
