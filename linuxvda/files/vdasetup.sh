#!/bin/bash
###########################################################
# This script is salt managed. Manual changes may be lost.
# Configuration is stored at the bottom for quick reference.
############################################################

#configure the Linux VDA single command

CTX_XDL_SUPPORT_DDC_AS_CNAME="{{ CTX_XDL_SUPPORT_DDC_AS_CNAME }}" \
CTX_XDL_DDC_LIST="{{ CTX_XDL_DDC_LIST }}" \
CTX_XDL_VDA_PORT="{{ CTX_XDL_VDA_PORT }}" \
CTX_XDL_REGISTER_SERVICE="{{ CTX_XDL_REGISTER_SERVICE }}" \
CTX_XDL_ADD_FIREWALL_RULES="{{ CTX_XDL_ADD_FIREWALL_RULES }}" \
CTX_XDL_AD_INTEGRATION="{{ CTX_XDL_AD_INTEGRATION }}" \
CTX_XDL_HDX_3D_PRO="{{ CTX_XDL_HDX_3D_PRO }}" \
CTX_XDL_VDI_MODE="{{ CTX_XDL_VDI_MODE }}" \
CTX_XDL_SITE_NAME="{{ CTX_XDL_SITE_NAME }}" \
CTX_XDL_LDAP_LIST="{{ CTX_XDL_LDAP_LIST }}" \
CTX_XDL_SEARCH_BASE="{{ CTX_XDL_SEARCH_BASE }}" \
CTX_XDL_START_SERVICE="{{ CTX_XDL_START_SERVICE }}" \
CTX_XDL_FAS_LIST="{{ CTX_XDL_FAS_LIST }}" \
{{ ctxsetup }}
exit $?

#
# Supported environment variables for quick reference.
#

#CTX_XDL_SUPPORT_DDC_AS_CNAME = Y | N
# The Linux VDA supports specifying a Delivery Controller name
# using a DNS CNAME record. This is typically set to N.

#CTX_XDL_DDC_LIST = list-ddc-fqdns
# – The Linux VDA requires a space-separated list of Delivery
# Controller Fully Qualified Domain Names. (FQDNs) to use for
# registering with a Delivery Controller. At least one FQDN 
# or CNAME alias must be specified.

#CTX_XDL_VDA_PORT = port-number
# – The Linux VDA communicates with Delivery Controllers using
# a TCP/IP port. This is typically port 80.

#CTX_XDL_REGISTER_SERVICE = Y | N
# - The Linux Virtual Desktop services support starting during
# boot. This is typically set to Y.

#CTX_XDL_ADD_FIREWALL_RULES = Y | N
# – The Linux Virtual Desktop services require incoming network
# connections to be allowed through the system firewall. You 
# can automatically open the required ports (by default ports 
# 80 and 1494) in the system firewall for the Linux Virtual 
# Desktop. This is typically set to Y.

#CTX_XDL_AD_INTEGRATION = 1 | 2 | 3 | 4
# – The Linux VDA requires Kerberos configuration settings to
# authenticate with the Delivery Controllers. The Kerberos 
# configuration is determined from the installed and configured
# Active Directory integration tool on the system. Specify the
# supported Active Directory integration method to use:
#1 – Samba Winbind
#2 – Quest Authentication Service
#3 – Centrify DirectControl
#4 – SSSD

#CTX_XDL_HDX_3D_PRO = Y | N
# – Linux Virtual Desktop supports HDX 3D Pro, a set of graphics
# acceleration technologies designed to optimize the virtualization
# of rich graphics applications. HDX 3D Pro requires a compatible 
# NVIDIA GRID graphics card to be installed. If HDX 3D Pro is
# selected, the Virtual Delivery Agent is configured for VDI
# desktops (single-session) mode – (i.e. CTX_XDL_VDI_MODE=Y).
# This is not supported on SUSE. Ensure that this value is set to N.

#CTX_XDL_VDI_MODE = Y | N
# - Whether to configure the machine as a dedicated desktop delivery
# model (VDI) or hosted shared desktop delivery model. For HDX 3D Pro
# environments, set this to Y. This is typically set to N.

#CTX_XDL_SITE_NAME = dns-name
# – The Linux VDA discovers LDAP servers using DNS, querying for LDAP
# service records. To limit the DNS search results to a local site,
# specify a DNS site name. This is typically empty [none].

#CTX_XDL_LDAP_LIST = list-ldap-servers
# – The Linux VDA by default queries DNS to discover LDAP servers.
# However if DNS cannot provide LDAP service records, you can provide
# a space-separated list of LDAP Fully Qualified Domain Names (FQDNs)
# with LDAP port (e.g. ad1.mycompany.com:389). This is typically
# empty [none].

#CTX_XDL_SEARCH_BASE = search-base
# – The Linux VDA by default queries LDAP using a search base set to
# the root of the Active Directory Domain (e.g. DC=mycompany,DC=com).
# However to improve search performance, you can specify a search base
# (e.g. OU=VDI,DC=mycompany,DC=com). This is typically empty [none].

#CTX_XDL_START_SERVICE = Y | N
# - Whether or not the Linux VDA services are started when the Linux
# VDA configuration is complete. This is typically set to Y.

