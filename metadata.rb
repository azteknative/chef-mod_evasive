name             'mod_evasive'
maintainer       'AzTek Native Ltd.'
maintainer_email 'peter.green@aztek-native.com'
license          'Apache 2.0'
description      'Installs/Configures mod_evasive'
long_description 'Installs/Configures mod_evasive'
version          '0.1.0'
%w{ apache
    yum-epel }.each do |d|

  depends d
end

