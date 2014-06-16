# OTRS Help Desk Software as Docker container

With this repository you can build a Docker image running OTRS with ITSM extension

## Using an external MySQL server

The image runs a MySQL server. If you prefer to use an external MySQL server, change the Dockerfile removing the installation of the `mysql-server` package and adding the `mysql-client` package. Comment out the _MySQL server setup_ lines and the installation of ITSM with internal MySQL server (and enable the installation of ITSM without MySQL server).

Also edit the `otrs/Config.pm` file with your db settings. You must set MySQL variables and import the `otrs/database.sql.gz` file in the corresponding database.
Edit the `supervisord.conf` file removing the `mysqld` section.

### IMPORTANT

To install ITSM, be sure that MySQL is accepting packages of 20MB or more. This can be done setting something like this in `my.cnf`:

```
[mysqld]
max_allowed_packet=32MB
```

This is mandatory or the build will fail while installing ITSM

## Disabling SSH server

SSH is active by default. You can comment the pertinent lines in the `Dockerfile` or, if you need it, set the root password in the same file (the $ROOT_PWD env variable)

## Build the container

```
docker build -t <my name>/otrs .
```

## Run the container

After the successful build, you can run the container with:

```
docker run -d -p 80 -p 22 <my name>/otrs
```

If you want to mount a volume to persist MySQL databases, remember to add the `-v` option:

```
docker run -d -p 80 -p 22 -v /<some_place>/mysql:/var/lib/mysql <my name>/otrs
```

## Access

With `docker ps` check the host's port mapping the port `80` of the container, in this example is `49154`.

* **Url:** http://localhost:49154/otrs/index.pl
* **Username:** root@localhost
* **Password:** c5g4v8Q2TT7aSpLk

### LDAP Authorization

If you want to permit the access from an LDAP server, add these lines (after proper customization) to the `otrs/Config.pm` file before building the image:

```
# This is an example configuration for an LDAP auth. backend.
# (Make sure Net::LDAP is installed!)
$Self->{'AuthModule'} = 'Kernel::System::Auth::LDAP';
$Self->{'AuthModule::LDAP::Host'} = '127.0.0.1';
$Self->{'AuthModule::LDAP::BaseDN'} = 'ou=people,dc=example,dc=com';
$Self->{'AuthModule::LDAP::UID'} = 'uid';

# Check if the user is allowed to auth in a posixGroup
# (e. g. user needs to be in a group xyz to use otrs)
# $Self->{'AuthModule::LDAP::GroupDN'} = 'cn=otrsallow,ou=posixGroups,dc=example,dc=com';
# $Self->{'AuthModule::LDAP::AccessAttr'} = 'memberUid';
# for ldap posixGroups objectclass (just uid)
#  $Self->{'AuthModule::LDAP::UserAttr'} = 'UID';
# for non ldap posixGroups objectclass (with full user dn)
#  $Self->{'AuthModule::LDAP::UserAttr'} = 'DN';

# The following is valid but would only be necessary if the
# anonymous user do NOT have permission to read from the LDAP tree
$Self->{'AuthModule::LDAP::SearchUserDN'} = 'cn=admin,dc=example,dc=com';
$Self->{'AuthModule::LDAP::SearchUserPw'} = 's3cr3t_p4ssw0rd';

# in case you want to add always one filter to each ldap query, use
# this option. e. g. AlwaysFilter => '(mail=*)' or AlwaysFilter => '(objectclass=user)'
$Self->{'AuthModule::LDAP::AlwaysFilter'} = '';

$Self->{'AuthModule::LDAP::UserAttr'} = 'CN';
$Self->{'AuthModule::LDAP::AccessAttr'} = 'member';

$Self->{'AuthSyncModule'} = 'Kernel::System::Auth::Sync::LDAP';
$Self->{'AuthSyncModule::LDAP::Host'} = 'ldap://127.0.0.1';
$Self->{'AuthSyncModule::LDAP::BaseDN'} = 'ou=people,dc=example,dc=com';
$Self->{'AuthSyncModule::LDAP::UID'} = 'uid';
$Self->{'AuthSyncModule::LDAP::UserSyncMap'} = {
  UserFirstname => 'givenName',
  UserLastname => 'sn',
  UserEmail => 'mail',
};
$Self->{'AuthSyncModule::LDAP::UserSyncInitialGroups'} = [
  'otrs',
];

# in case you want to add a suffix to each login name, then
# you can use this option. e. g. user just want to use user but
# in your ldap directory exists user@domain.
#    $Self->{'AuthModule::LDAP::UserSuffix'} = '@domain.com';

# Net::LDAP new params (if needed - for more info see perldoc Net::LDAP)
$Self->{'AuthModule::LDAP::Params'} = {
  port => 389,
  timeout => 120,
  async => 0,
  version => 3,
};
```

## FAQ Module

If you need the FAQ module, sign in to OTRS and go to "Admin > Package Manager" (i.e. /otrs/index.pl?Action=AdminPackageManager), refresh repository info, then click **install** to the FAQ module

## Troubleshooting

If you get an "Internal server error" at any moment with OTRS, probably is a permission problem. You can check `/var/log/apache/error.log` to be sure.
In this case the following command (run as root) will probably fix the problem:

```
cd /opt/otrs/bin && ./otrs.SetPermissions.pl /opt/otrs --otrs-user=otrsserviceuser --otrs-group=nogroup --web-user=www-data --web-group=www-data
```
