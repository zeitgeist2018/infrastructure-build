version: '3'
services:
  nginx:
    image: 'nginx:1.17.10'
    container_name: 'nginx-master'
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - "./conf/sites-available:/etc/nginx/sites-available"
      - "./conf/sites-enabled:/etc/nginx/sites-enabled"
      - "./conf/nginx.conf:/etc/nginx/nginx.conf"
      - "./ssl:/etc/nginx/ssl:ro"
      - "{{ .DATA_FOLDER }}/dns-server/reverse-proxy/logs:/var/log/nginx:rw"
