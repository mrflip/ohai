#
# Author:: Cary Penniman (<cary@rightscale.com>)
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

provides "cloud"

require_plugin "ec2"
require_plugin "rackspace"
require_plugin "eucalyptus"
require_plugin "virtualbox"

# Make top-level cloud hashes
#
def create_objects
  cloud Mash.new
  cloud[:public_ips] = Array.new
  cloud[:private_ips] = Array.new
end

# ----------------------------------------
# ec2
# ----------------------------------------

# Is current cloud ec2?
#
# === Return
# true:: If ec2 Hash is defined
# false:: Otherwise
def on_ec2?
  ec2 != nil
end

# Fill cloud hash with ec2 values
def get_ec2_values
  cloud[:public_ips] << ec2['public_ipv4']
  cloud[:private_ips] << ec2['local_ipv4']
  cloud[:public_ipv4] = ec2['public_ipv4']
  cloud[:public_hostname] = ec2['public_hostname']
  cloud[:local_ipv4] = ec2['local_ipv4']
  cloud[:local_hostname] = ec2['local_hostname']
  cloud[:provider] = "ec2"
end

# setup ec2 cloud
if on_ec2?
  create_objects
  get_ec2_values
end

# ----------------------------------------
# rackspace
# ----------------------------------------

# Is current cloud rackspace?
#
# === Return
# true:: If rackspace Hash is defined
# false:: Otherwise
def on_rackspace?
  rackspace != nil
end

# Fill cloud hash with rackspace values
def get_rackspace_values
  cloud[:public_ips] << rackspace['public_ip']
  cloud[:private_ips] << rackspace['private_ip']
  cloud[:public_ipv4] = rackspace['public_ipv4']
  cloud[:public_hostname] = rackspace['public_hostname']
  cloud[:local_ipv4] = rackspace['local_ipv4']
  cloud[:local_hostname] = rackspace['local_hostname']
  cloud[:provider] = "rackspace"
end

# setup rackspace cloud
if on_rackspace?
  create_objects
  get_rackspace_values
end

# ----------------------------------------
# eucalyptus
# ----------------------------------------

# Is current cloud eucalyptus?
#
# === Return
# true:: If eucalyptus Hash is defined
# false:: Otherwise
def on_eucalyptus?
  eucalyptus != nil
end

def get_eucalyptus_values
  cloud[:public_ips] << eucalyptus['public_ipv4']
  cloud[:private_ips] << eucalyptus['local_ipv4']
  cloud[:public_ipv4] = eucalyptus['public_ipv4']
  cloud[:public_hostname] = eucalyptus['public_hostname']
  cloud[:local_ipv4] = eucalyptus['local_ipv4']
  cloud[:local_hostname] = eucalyptus['local_hostname']
  cloud[:provider] = "eucalyptus"
end

if on_eucalyptus?
  create_objects
  get_eucalyptus_values
end

# ----------------------------------------
# virtualbox
# ----------------------------------------

# Is current cloud virtualbox?
#
# === Return
# true:: If virtualbox Hash is defined
# false:: Otherwise
def on_virtualbox?
  virtualbox != nil
end

# Fill cloud hash with virtualbox heuristics
def get_virtualbox_values
  cloud[:public_ips]      = virtualbox['public_ips']
  cloud[:private_ips]     = virtualbox['private_ips']
  cloud[:public_ipv4]     = virtualbox['public_ipv4']
  cloud[:public_hostname] = virtualbox['public_hostname']
  cloud[:local_ipv4]      = virtualbox['local_ipv4']
  cloud[:local_hostname]  = virtualbox['local_hostname']
  cloud[:provider]        = "virtualbox"
end

if on_virtualbox?
  create_objects
  get_virtualbox_values
end
