server {
    listen 80;
    server_name jenkins.dev.local;

    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl http2;

    ssl_certificate             /etc/nginx/ssl/dev.local.crt;
    ssl_certificate_key         /etc/nginx/ssl/dev.local.private.key;
    ssl_session_cache           builtin:1000  shared:SSL:10m;
    ssl_protocols               TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers                 HIGH:!aNULL:!eNULL:!EXPORT:!CAMELLIA:!DES:!MD5:!PSK:!RC4;
    ssl_prefer_server_ciphers   on;

    access_log                  /var/log/nginx/jenkins.access.log;
    server_name                 jenkins.dev.local;

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

