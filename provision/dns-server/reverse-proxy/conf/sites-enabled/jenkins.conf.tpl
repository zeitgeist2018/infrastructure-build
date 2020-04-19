server {
    listen 80;
    server_name jenkins.dev.local;

    location / {
        proxy_pass              http://{{ .HOST }}:{{ .JENKINS_PORT }};
        proxy_set_header        Host $host:$server_port;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Host $host;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_read_timeout      90;
        proxy_redirect          http://{{ .HOST }}:{{ .JENKINS_PORT }} {{ .JENKINS_URL }};
    }
}

#server {
#    listen 80;
#    server_name jenkins.dev.local;
#
#    location / {
#        return 307 https://$host$request_uri;
#    }
#}

#server {
#    listen 443 ssl http2;
#    ssl_certificate /etc/nginx/ssl/infrastructure-build.crt;
#    ssl_certificate_key /etc/nginx/ssl/infrastructure-build.private.key;
#    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
#    ssl_ciphers HIGH:!aNULL:!MD5;
#
#    server_name jenkins.dev.local;
#    location / {
#        proxy_pass http://192.168.1.100:8080;
#    }
#}

