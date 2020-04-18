#log all dns queries
log-queries

#dont use hosts nameservers
no-resolv

#explicitly define host-ip mappings
address=/artifactory.dev.local/{{ .HOST }}
address=/jenkins.dev.local/{{ .HOST }}
address=/gitlab.dev.local/{{ .HOST }}

#use google as default nameservers
server=8.8.4.4
server=8.8.8.8
