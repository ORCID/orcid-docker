Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

notify{"Using environment $environment":}

include bootstrap
include stdlib
include orcid_base::baseapps
include orcid_base::common_libs
include orcid_python
include orcid_java
include orcid_maven
