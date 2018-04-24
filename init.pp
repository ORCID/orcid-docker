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
# include orcid_maven
exec {"download_maven33":
    command => "wget -O $tar_file https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz",
    creates => $tar_file,
    require => Package['maven']
}
exec {"extract_maven33":
    command => "tar -xzf $tar_file -C /opt/",
    creates => "/opt/apache-maven-3.3.9",
    require => Exec["download_maven33"]
}
file {"/opt/maven33":
    ensure => link,
    target => '/opt/apache-maven-3.3.9',
    require => Exec['extract_maven33']
}
exec {"update_mvn_alternatives":
    command => "update-alternatives --install /usr/bin/mvn mvn /opt/maven33/bin/mvn 339 --slave /usr/bin/mvnDebug mvnDebug /opt/maven33/bin/mvnDebug",
    require => File['/opt/maven33']
}
# include orcid_tomcat







#notify{"Using environment $environment":}

# include bootstrap
# include stdlib
# include orcid_base::baseapps
# include orcid_base::common_libs

$packagelist = [
    "python-software-properties"
]
# "libcurl4-openssl-dev",
# "build-essential",
# "libssl-dev",
# "python-setuptools",
# "libffi-dev",
# "python2.7-dev",
# "python-dev",
# "libpq-dev",
# "python-openssl",
# "python-pip",
# "python-psycopg2",
# "python"