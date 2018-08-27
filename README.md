Cloud Farmer is a multi-cloud server deployment tool, based on Server Farmer.
It allows full lifecycle, fully automatic management of Linux-based cloud
instances, supporting all important cloud computing vendors:

- Alibaba Cloud
- Amazon Web Services
- Beyond e24cloud.com
- Google Cloud Platform
- Hetzner Cloud
- Microsoft Azure
- Rackspace Cloud
- any cloud service based on OpenStack (including public, private and hybrid clouds)

All supported providers are well tested with Ubuntu 14.04 LTS, 16.04 LTS and 18.04 LTS,
and also are expected to work without major problems with any recent Debian or Ubuntu
version).


## Example usage

### Installation

Cloud Farmer requires Server Farmer installed, with configured roles farm-manager,
farm-provisioning, and preferably also backup-collector.

```
git clone https://github.com/serverfarmer/cloudfarmer /opt/cloud
/opt/cloud/install.sh
/opt/cloud/api/account/setup.sh yourprovider youraccount
```

where `yourprovider` is one of: `azure`, `e24`, `ec2`, `gce` or `rackspace`, and
`youraccount` is the name of your configured account (`e24`, `ec2` and `rackspace`
support having multiple accounts at the same time).

Note that for `azure` and `gce`, the setup process needs browser interaction.

For `rackspace` provider, the configuration process will ask you for a Profile Name.
Cloud Farmer works only with named profiles, not with the default nameless profile, so
you have to type some non-empty name there, even if you use only one Rackspace account.

After you finished the initial setup, you can always manually edit files inside
`/etc/local/.cloud` directory to make sure that your provider is properly configured.

### Creating new cloud instance

```
/opt/cloud/create.sh ec2 prod test_key1 m4.xlarge
/opt/cloud/create.sh azure default testkey2 Standard_A2
/opt/cloud/create.sh rackspace office test_key3 compute1-60
/opt/cloud/create.sh e24 testing testkey4 m1.small
/opt/cloud/create.sh gce default testkey5 n1-highcpu-2
```

### Installing Server Farmer on new cloud instance

```
/opt/cloud/provision.sh ec2 ec2-54-123-45-67.compute-1.amazonaws.com test_key1 default
/opt/cloud/provision.sh azure testkey2-5c82.eastus.cloudapp.azure.com testkey2 default
/opt/cloud/provision.sh rackspace 162.209.99.47 test_key3 default
/opt/cloud/provision.sh e24 ip-178-216-203-155.e24cloud.com testkey4 default
/opt/cloud/provision.sh gce 204.111.199.104.bc.googleusercontent.com testkey5 default
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
| **Copyright:**       | Copyright 2015-2018 Tomasz Klim          |
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
