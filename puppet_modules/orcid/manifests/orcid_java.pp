Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}
# include orcid_python
package { "software-properties-common":
    ensure => installed
}
# include orcid_java
exec { "java_add_webupd8team":
    command => "add-apt-repository -y ppa:webupd8team/java",
    creates => "/etc/apt/sources.list.d/webupd8team-java-trusty.list",
    require => Package['software-properties-common']
}
exec { "java_debconf":
    command => "/bin/echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections",
    creates => "/usr/lib/jvm/java-8-oracle/bin/java",
    require => Exec['java_add_webupd8team']
}
exec { "java_refresh_apt":
    command => "apt-get update",
    creates => "/usr/lib/jvm/java-8-oracle/bin/java",
    require => Exec["java_debconf"]
}
package { ["oracle-java8-installer", "oracle-java8-set-default", "oracle-java8-unlimited-jce-policy", "maven"]:
    ensure => installed,
    require => Exec['java_refresh_apt']
}
