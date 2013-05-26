#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: transmission
# Attribute:: default
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

case node['platform']
when "ubuntu","debian"
  default['transmission']['install_method'] = 'package'
  default['transmission']['user']           = 'debian-transmission'
  default['transmission']['group']          = 'debian-transmission'
else
  default['transmission']['install_method'] = 'source'
  default['transmission']['user']           = 'transmission'
  default['transmission']['group']          = 'transmission'
end

default['transmission']['settings_mode']    = '660' #Controls the mode of settings.json
                                                    # '660' allows the transmission daemon to update the settings, e.g. from the web interface
                                                    # '640' only allows changes by root/chef
                                                    # This file should never be world readable; it contains the RPC password.

default['transmission']['url']              = 'http://download.transmissionbt.com/files'
default['transmission']['version']          = '2.03'
default['transmission']['checksum']         = '06802c6f4ba517341eb287b273145ccd5e7b0fba2a270da82f0eb0a683cf4046'

default['transmission']['bind_ipv4']               = "0.0.0.0"
default['transmission']['bind_ipv6']               = "::"
default['transmission']['encryption']              = 1 #(0=Prefer unencrypted, 1=Prefer encrypted, 2=Require encrypted)
default['transmission']['dht_enabled']             = 'true'
default['transmission']['blocklist_enabled']       = 'false' #This is mostly useless these days, but here if you want it
default['transmission']['blocklist_url']           = "http://www.example.com/blocklist" #You need to change this if enabling blocklist

default['transmission']['peer_port']               = 51413
default['transmission']['peer_port_random']        = 'false'
default['transmission']['peer_port_random_min']    = 49152
default['transmission']['peer_port_random_max']    = 65535
default['transmission']['peer_socket_tos']         = 0
default['transmission']['peer_port_forward']       = 'false'

default['transmission']['peer_exchange']    = 'true'

default['transmission']['rpc_enabled'] = 'true'
default['transmission']['rpc_whitelist_enabled'] = 'true'
default['transmission']['rpc_whitelist'] = '127.0.0.1'
default['transmission']['rpc_bind_address'] = '0.0.0.0'
default['transmission']['rpc_username']     = 'transmission'
set_unless['transmission']['rpc_password']  = secure_password
default['transmission']['rpc_port']         = 9091

default['transmission']['umask']            = 18
default['transmission']['home']             = '/var/lib/transmission-daemon'
default['transmission']['config_dir']       = '/var/lib/transmission-daemon/info'
default['transmission']['download_dir']     = '/var/lib/transmission-daemon/downloads'
default['transmission']['incomplete_dir']   = '/var/lib/transmission-daemon/incomplete'
default['transmission']['incomplete_dir_enabled'] = 'false'

#Baseline speed limits, these are the absolute highest that should be permitted
default['transmission']['speed_limit_down']         = 1000 #KB/s
default['transmission']['speed_limit_down_enabled'] = 'false'
default['transmission']['speed_limit_up']           = 1000 #KB/s
default['transmission']['speed_limit_up_enabled']   = 'false'
#These are 'alternate' a.k.a. 'daytime' speed limits to help you avoid pissing off your local Network Admin :)

default['transmission']['alt_speed_limit_enabled']  = 'false' #this controls both alt-speed-time-enabled and alt-speed-enabled 
                                                              # since from a conf standpoint they should both start on or off, 
                                                              # then alt-speed-enabled should vary according to time.
default['transmission']['alt_speed_limit_down']     = 1000 #KB/s
default['transmission']['alt_speed_limit_up']       = 100 #KB/s
default['transmission']['alt_speed_limit_begin']    = 540 #(default = 540, in minutes from midnight, 09:00)
default['transmission']['alt_speed_limit_end']      = 1020 #(default = 1020, in minutes from midnight, 17:00)
default['transmission']['alt_speed_limit_day']      = 127 #(default = 127, all days)
                                                          # Start with 0, then for each day you want the scheduler enabled, add:
                                                          #   Sunday: 1 (binary: 0000001)
                                                          #   Monday: 2 (binary: 0000010)
                                                          #   Tuesday: 4 (binary: 0000100)
                                                          #   Wednesday: 8 (binary: 0001000)
                                                          #   Thursday: 16 (binary: 0010000)
                                                          #   Friday: 32 (binary: 0100000)
                                                          #   Saturday: 64 (binary: 1000000)
                                                          # Examples:
                                                          #   Weekdays: 62 (binary: 0111110)
                                                          #   Weekends: 65 (binary: 1000001)
                                                          #   All Days: 127 (binary: 1111111)


default['transmission']['peer_limit']               = 200
default['transmission']['peer_limit_global']        = 240
default['transmission']['peer_limit_torrent']       = 60
