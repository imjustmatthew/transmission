## v1.2.0
* Exposed additional settings from Transmission
* We now create two copies of settings.json instead of trying to 
  symlink the file. Certain configurations on Ubuntu result in 
  apt creating a symlink as well -- in the oppostie direction -- 
  causing crashes when we run with chef-client.
* settings.json is now set to be owned by Transmission's group, 
  not root. This aligns with the default install from packages.
* settings.json is no longer world-readable by default; it 
  contains the RPC login, which needs to be protected.
* Added node['transmission']['settings_mode'] which controls the
  permissions on settings.json; the default is 660, allowing the
  settings to be changed by transmission from the web interface.
  If this is undesirable, the mode should be set to 640, 
  preventing changes to the configuration except by root/chef.



## v1.0.2:

* [COOK-729] - `transmission_torrent_file` doesn't work for more than
  a single torrent
* [COOK-732] - link to file in swarm not created if torrent already
  completely downloaded
