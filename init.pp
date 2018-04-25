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
$tar_file = "/opt/apache-maven-3.3.9-bin.tar.gz"
exec {"download_maven33":
    command => "/usr/bin/wget -O $tar_file https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz",
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
$tomcat_home                  = "/home/orcid_tomcat"
$tomcat_tar_url               = "http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.21/bin/"
$tomcat_tar_basename          = "apache-tomcat-8.0.21"
$tomcat_tar_file              = "${tomcat_home}/${tomcat_tar_basename}.tar.gz"
file { "$tomcat_home/git":
    ensure  => directory,
    mode    => "0775",
    owner   => orcid_tomcat,
    group   => orcid_tomcat
}
exec { "download_tomcat_distro":
    onlyif   => "test -d $tomcat_home && test ! -f $tomcat_tar_file",
    command  => "wget -O $tomcat_tar_file $tomcat_tar_url/${tomcat_tar_basename}.tar.gz",
    creates  => "$tomcat_tar_file"
}
exec { "untar_$tomcat_tar_basename":
    onlyif  => "test -d $tomcat_home && test ! -d $tomcat_home/$tomcat_tar_basename",
    command => "echo && cd $tomcat_home && tar xzf $tomcat_tar_file && chown -R orcid_tomcat:orcid_tomcat $tomcat_home/$tomcat_tar_basename",
    creates => "$tomcat_home/$tomcat_tar_basename"
}
file { "$tomcat_home/$tomcat_tar_basename":
    ensure    => directory,
    recurse   => true,
    owner     => $tomcat_owner,
    group     => $tomcat_owner,
    require   => Exec["untar_$tomcat_tar_basename"]
}
file {"$tomcat_home/tomcat":
    ensure  => link,
    owner   => $tomcat_owner,
    group   => $tomcat_owner,
    target  => "$tomcat_home/$tomcat_tar_basename",
    require => Exec["untar_$tomcat_tar_basename"]
}
file { [ "$tomcat_home/tomcat/data", "$tomcat_home/tomcat/data/solr"]:
    ensure => directory,
    mode   => "0700",
    owner  => orcid_tomcat,
    group  => orcid_tomcat,
    require=> File["$tomcat_home/tomcat"]
}
# file { "/home/orcid_tomcat/tomcat/conf/server.xml":
#     ensure  => file,
#     source  => "puppet:///modules/orcid_tomcat/tomcat_conf_server.min.xml",
#     mode    => '0755',
#     group   => 'orcid_tomcat',
#     owner   => 'orcid_tomcat',
#     require => File["$tomcat_home/tomcat"]
# }



























