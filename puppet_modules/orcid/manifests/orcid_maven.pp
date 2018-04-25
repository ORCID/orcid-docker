Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}
# include orcid_maven
package { ["maven"]:
    ensure => installed
}
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
