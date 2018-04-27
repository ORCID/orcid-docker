Exec {
    path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}
# orcid_postgresql
$version = "9.5"
$pg_package_name = "postgresql-${version}"
package {"curl":
    ensure => installed
}
exec { "pg_install_apt_key":
    onlyif  => "test $(apt-key list | grep postgresql | wc -l) -eq 0",
    command => "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -",
    require => Package['curl']
}
file { "/etc/apt/sources.list.d/pgdg.list":
    ensure  => file,
    replace => no,
    content => "deb http://apt.postgresql.org/pub/repos/apt/ DISTROCODENAME-pgdg main",
    require => Exec['pg_install_apt_key']
}
exec { "pg_update_codename":
    creates => "/usr/bin/psql",
    onlyif  => "test $(grep $(lsb_release -cs) /etc/apt/sources.list.d/pgdg.list | wc -l) -eq 0",
    command => "sed -i s/DISTROCODENAME/$(lsb_release -cs)/g /etc/apt/sources.list.d/pgdg.list",
    require => File["/etc/apt/sources.list.d/pgdg.list"]
}
exec { "pg_upgate_ubuntu_packages_db":
    creates => "/usr/bin/psql",
    command => "apt-get update 2>&1 > /dev/null",
    require => Exec['pg_update_codename']
}
package{["$pg_package_name", "postgresql-common", "postgresql-contrib-9.5"]:
    ensure  => installed,
    require => Exec['pg_upgate_ubuntu_packages_db']
}
# file { "/etc/postgresql/$version/main/pg_hba.conf":
#     ensure  => file,
#     backup  => true,
#     owner   => 'postgres',
#     group   => 'postgres',
#     mode    => '0440',
#     source  => "puppet:///modules/$hba",
#     require => Package[$pg_package_name],
# }
# file { "/etc/postgresql/$version/main/postgresql.conf":
#     ensure  => file,
#     backup  => true,
#     owner   => 'postgres',
#     group   => 'postgres',
#     mode    => '0440',
#     source  => "puppet:///modules/$conf",
#     require => Package[$pg_package_name],
# }
