Exec {
    path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
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
file { "/home/orcid_tomcat/tomcat/conf/server.xml":
    ensure  => file,
    source  => "puppet:///modules/orcid/tomcat_conf_server.min.xml",
    mode    => '0755',
    group   => 'orcid_tomcat',
    owner   => 'orcid_tomcat',
    require => File["$tomcat_home/tomcat"]
}