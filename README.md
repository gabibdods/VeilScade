# personal_proxy_server
Steps used to build a Squid proxy server, using the built in a storage cache and a password-generator utility from the Apache Project to serve authenticated users fast http request.

. sudo apt update && sudo apt upgrade -y
  updates : updates the list of available packages and their version, but it does not install or upgrade any packages.
  upgrade : installs the newest version in the list of available packages installed, while logging the installed newest version of packages to the package manager
  -y : yes to install package that take ??? XB.
  
. sudo apt intall squid

. sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.original
  creates a copy of the default settings, in the case of a rollback or of a hard reset
  other extension : .conf.bkup | .conf.default
  
. sudo apt install apache2-utils
  install utiities from the Apache project to use a password generator recognizable by Squid
  
. sudo nano /etc/squid/squid.conf
  use nano to modify configurations of the proxy server

in /etc/squid/squid.conf :
	http_port <custom_http_port>
	  port 3124 is the default port for Squid, port 8888 is conventional for proxy servers, however other ports are available; CAREFUL not connect to a port already being used by another service
	cache_dir ufs /var/spool/squid 1000 16 256
	  natively Squid used memory as cache, so it is preferable to specify the cache to be a directory on the storage
	  storage format : ufs (Universal Flash Storage : higher data transfer speed and increased reliability) | afs (Andrew File System : present a homogeneous, location-transparent file name space to all the client workstations)
	  first number : allocated space in MB for proxy cache (to store previously visited websites for faster traffic)
	  second number : number of level-1 subdirectories created in the cache directory
	  thrid number : number of level-2 subdirectories created in the cache directory (level-2 directories are created in level-1 directories)
	auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwords
	  uses NCSA authenticator to login squid user (the client)
	  usernames and encrypted passwords are stored in /etc/squid/passwords
	auth param basic program realm proxy
	  specifies the protection scope to be reported to the client for the authentification scheme
	auth_param basic credentialsttl 24 hours
	  Time-To-Live until the credentials (the token) expires and needs to be renewed
	auth_param basic casesensitive off
	  case sensitivity turned off for user, can be turned on for more security
	acl authenticated proxy_auth REQUIRED
	  set up for authentication scheme
	acl <proxy_host_name> src 192.168.x.0/24
	  grant access control to <proxy_host_name> for source connections coming from argument : <client_IPv4>/24
	http_access deny !authenticated
	  deny http to users who are not authenticated
	http_access allow authenticated
	  allow access to user who are authenticated, which should prompt a login pop-up for the client
	http_access allow <proxy_host_name>
	  allow http to <proxy_host_name>
	http_access deny all
	  deny http to everyone else
	forwarded_for delete
	  remove the forwarded_for http header which exposes the source to the destination (the client to the host)
	  
to create a username and a password for authentication :
	sudo touch /etc/squid/passwords
	  creates /etc/squid/passwords with root permissions
	sudo chmod 777 /etc/squid/passwords
	  NOT TO BE USED IN A SCALE LARGER THAN PERSONAL NETWORK, sudo chmod 777 is bad practice and should only be used to bypass inconvenient permission issues for i.e. testing purposes
	  
	  so run this :
	  
	sudo htpasswd 
	  
	sudo htpasswd -c /etc/squid/passwords <username>
	  type password for <username> (it is normal for the terminal to not print "*" when typing passwords, for real-life security reasons)

. sudo cat /etc/squid/passwords
  prints this format for each user : <username> : <encrypted password>

. sudo systemctl restart squid.service
  tells systemd to reboot Squid
  ALWAYS IMPORTANT to restart (reboot) a server to apply changes, especially configuration changes
  
. sudo ufw allow <custom_http_port>	
	tells Uncomplicated FireWall on Ubuntu systems to allow connections from <custom_http_port>
	
debugging commands :
	sudo less /var/log/squid/access.log
	  access the connection logs
		cache hit code :	TCP_HIT			: request was served from cache and not original server
							TCP_TUNNEL		: request is being served bypassing firewall restrictions (TCP endpoint)
							TCP_MISS		: request could not be served from cache, it was forwarded to original server
							TCP_EXPIRED		: request was served with a resource from cache, but the resource is expired, so a new request is sent to original server for an updated resource
							TCP_UPDATING	: continuation of TCP_EXPIRED; the request for an updated resource is being fetched from the original server to update cache
							TCP_DENIED		: request denied (check login info from client and connection from host)

	curl -v -x http://<username>:<password>@<host_IPv4>:<custom_http_port> https://duckduckgo.com/
	  simulates a request from an allowed ACL to duckduckgo.com


help from :
	https://www.squid-cache.org/
	https://gist.github.com/jackblk/fdac4c744ddf2a0533278a38888f3caf
