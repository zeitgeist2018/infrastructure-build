server {
    listen 80;
    server_name artifactory.dev.local;
      
    location / {
        proxy_pass "http://{{ .HOST }}:{{ .ARTIFACTORY_PORT }}";
    }
}

server {
    listen 80;
    server_name jenkins.dev.local;

    location / {
        proxy_pass "http://{{ .HOST }}:{{ .JENKINS_PORT }}";
    }
}

server {
    listen 80;
    server_name gitlab.dev.local;

    location / {
        proxy_pass "http://{{ .HOST }}:{{ .GITLAB_PORT }}";
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
#        proxy_pass "http://192.168.1.100:8080";
#    }
#}

