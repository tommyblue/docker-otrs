# OTRS

## Before building the image

Edit the file `otrs/Config.pm` with your settings. You must set MySQL variables and import the `otrs/database.sql.gz` file in the corresponding database.

SSH is active by default. You can comment the pertinent lines in the `Dockerfile` or, if you need it, set the root password in the same file (the $ROOT_PWD env variable)

If you don't need LDAP authentication, comment out the related lines in `otrs/Config.pm`, elsewhere customize the variables to fit your needs.

### IMPORTANT

To install ITSM, be sure that MySQL is accepting packages of 20MB or more. This can be done setting something like this in `my.cnf`:

```
[mysqld]
max_allowed_packet=32MB
```

This is mandatory or the build will fail while installing ITSM

## Build the container

```
docker build -t <my name>/otrs .
```

## Run the container

After the successful build, you can run the container with:

```
docker run -d -p 80 -p 22 <my name>/otrs
```

## Access

Url: http://localhost:49154/otrs/index.pl
Username: root@localhost
Password: c5g4v8Q2TT7aSpLk

## FAQ Module

If you need the FAQ module, sign in to OTRS and go to "Admin > Package Manager" (i.e. /otrs/index.pl?Action=AdminPackageManager), refresh repository info, then click **install** to the FAQ module

## Troubleshooting

If you get an "Internal server error" at any moment with OTRS, probably is a permission problem. You can check `/var/log/apache/error.log` to be sure.
In this case just this command (run as root) will probably fix the problem:

```
cd /opt/otrs/bin && ./otrs.SetPermissions.pl /opt/otrs --otrs-user=otrsserviceuser --otrs-group=nogroup --web-user=www-data --web-group=www-data
```
