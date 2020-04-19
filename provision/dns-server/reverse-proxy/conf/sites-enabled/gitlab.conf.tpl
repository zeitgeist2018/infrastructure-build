server {
    listen 80;
    server_name gitlab.dev.local;

    location / {
        proxy_pass              http://{{ .HOST }}:{{ .GITLAB_PORT }};
        proxy_set_header        Host $host:$server_port;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Host $host;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_read_timeout      90;
        proxy_redirect          http://{{ .HOST }}:{{ .GITLAB_PORT }} {{ .GITLAB_URL }};
    }
}
