class mongodb
(
    $repoAlias = 'mongodb-repo',
    $repoUrl
)
{

	validate_string( $repoAlias )
	validate_string( $repoUrl )

	$packageName = 'mongodb'
	$serviceName = 'mongodb'

        zypprepo { $repoAlias :
                baseurl         => $repoUrl,
                enabled         => 1,
                autorefresh     => 1,
                name            => $repoAlias,
                gpgcheck        => 0,
        }

        package { $packageName :
                ensure  => latest,
                #install_options => [ "--from ${repoAlias}" ],
                require => Zypprepo[ $repoAlias ],
        }

        service { $serviceName :
                ensure  => running,
                enable  => true,
		require => Package[ $packageName ],
        }

}
