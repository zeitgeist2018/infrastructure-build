server {
    listen 80;
    server_name {{ .ARTIFACTORY_JCR_DOMAIN }};

    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl http2;

    ssl_certificate             /etc/nginx/ssl/servercert.pem;
    ssl_certificate_key         /etc/nginx/ssl/serverkey.pem;
    ssl_session_cache           builtin:1000  shared:SSL:10m;
    ssl_protocols               TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers                 HIGH:!aNULL:!eNULL:!EXPORT:!CAMELLIA:!DES:!MD5:!PSK:!RC4;
    ssl_prefer_server_ciphers   on;

    access_log                  /var/log/nginx/artifactory-jcr.access.log;
    server_name                 {{ .ARTIFACTORY_JCR_DOMAIN }};

    location / {
        proxy_pass              http://{{ .HOST }}:{{ .ARTIFACTORY_JCR_PORT }};
        client_max_body_size    0;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_set_header        X-Forwarded-Port $http_x_forwarded_port;
        proxy_set_header        X-Forwarded-Host $host;
        proxy_set_header        X-Artifactory-Override-Base-Url https://$host/artifactory;
        proxy_read_timeout      90;
        proxy_redirect          https://{{ .HOST }}:{{ .ARTIFACTORY_JCR_PORT }} {{ .ARTIFACTORY_JCR_URL }};
    }
}

