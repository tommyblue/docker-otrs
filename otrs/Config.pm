# --
# Kernel/Config.pm - Config file for OTRS kernel
# Copyright (C) 2001-2013 OTRS AG, http://otrs.org/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
#  Note:
#
#  -->> Most OTRS configuration should be done via the OTRS web interface
#       and the SysConfig. Only for some configuration, such as database
#       credentials and customer data source changes, you should edit this
#       file. For changes do customer data sources you can copy the definitions
#       from Kernel/Config/Defaults.pm and paste them in this file.
#       Config.pm will not be overwritten when updating OTRS.
# --

package Kernel::Config;

use strict;
use warnings;
use utf8;

sub Load {
  my $Self = shift;

  # ---------------------------------------------------- #
  # database settings                                    #
  # ---------------------------------------------------- #

  # The database host
  $Self->{'DatabaseHost'} = '172.17.42.1';

  # The database name
  $Self->{'Database'} = "otrs";

  # The database user
  $Self->{'DatabaseUser'} = "otrs";

  # The password of database user. You also can use bin/otrs.CryptPassword.pl
  # for crypted passwords
  $Self->{'DatabasePw'} = '12345678';

  # The database DSN for MySQL ==> more: "perldoc DBD::mysql"
  $Self->{'DatabaseDSN'} = "DBI:mysql:database=$Self->{Database};host=$Self->{DatabaseHost}";

  # The database DSN for PostgreSQL ==> more: "perldoc DBD::Pg"
  # if you want to use a local socket connection
  #    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};";
  # if you want to use a TCP/IP connection
  #    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};host=$Self->{DatabaseHost};";
  # if you have PostgresSQL 8.1 or earlier, activate the legacy driver with this line:
  #    $Self->{DatabasePostgresqlBefore82} = 1;

  # The database DSN for Microsoft SQL Server - only supported if OTRS is
  # installed on Windows as well
  #    $Self->{DatabaseDSN} = "DBI:ODBC:driver={SQL Server};Database=$Self->{Database};Server=$Self->{DatabaseHost},1433";

  # The database DSN for Oracle ==> more: "perldoc DBD::oracle"
  #    $ENV{ORACLE_HOME} = '/u01/app/oracle/product/10.2.0/client_1';
  #    $ENV{NLS_DATE_FORMAT} = 'YYYY-MM-DD HH24:MI:SS';
  #    $ENV{NLS_LANG} = "american_america.utf8";

  #    $Self->{DatabaseDSN} = "DBI:Oracle:sid=OTRS;host=$Self->{DatabaseHost};port=1522;";

  # ---------------------------------------------------- #
  # fs root directory
  # ---------------------------------------------------- #
  $Self->{Home} = '/opt/otrs';

  # ---------------------------------------------------- #
  # insert your own config settings "here"               #
  # config settings taken from Kernel/Config/Defaults.pm #
  # ---------------------------------------------------- #
  # $Self->{SessionUseCookie} = 0;
  # $Self->{CheckMXRecord} = 0;

  # ---------------------------------------------------- #

  # ---------------------------------------------------- #
  # data inserted by installer                           #
  # ---------------------------------------------------- #
  # $DIBI$

  # This is an example configuration for an LDAP auth. backend.
  # (Make sure Net::LDAP is installed!)
  $Self->{'AuthModule'} = 'Kernel::System::Auth::LDAP';
  $Self->{'AuthModule::LDAP::Host'} = '172.17.42.1';
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
  $Self->{'AuthModule::LDAP::SearchUserPw'} = 's3cr3t';

  # in case you want to add always one filter to each ldap query, use
  # this option. e. g. AlwaysFilter => '(mail=*)' or AlwaysFilter => '(objectclass=user)'
  $Self->{'AuthModule::LDAP::AlwaysFilter'} = '';

  $Self->{'AuthModule::LDAP::UserAttr'} = 'CN';
  $Self->{'AuthModule::LDAP::AccessAttr'} = 'member';

  $Self->{'AuthSyncModule'} = 'Kernel::System::Auth::Sync::LDAP';
  $Self->{'AuthSyncModule::LDAP::Host'} = 'ldap://172.17.42.1';
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
  # default language
  # (the default frontend language) [default: en]
  #$Self->{DefaultLanguage} = 'it';
  # ---------------------------------------------------- #
  # ---------------------------------------------------- #
  #                                                      #
  # end of your own config options!!!                    #
  #                                                      #
  # ---------------------------------------------------- #
  # ---------------------------------------------------- #
}

# ---------------------------------------------------- #
# needed system stuff (don't edit this)                #
# ---------------------------------------------------- #

use base qw(Kernel::Config::Defaults);

# -----------------------------------------------------#

1;
