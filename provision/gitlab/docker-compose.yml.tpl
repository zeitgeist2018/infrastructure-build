version: '3.5'
services:
  gitlab:
    image: gitlab/gitlab-ce:12.9.2-ce.0
    container_name: gitlab-master
    hostname: {{ .GITLAB_URL }}
    restart: unless-stopped
    ports:
      - "{{ .GITLAB_PORT }}:80"    # TODO: Expose only to 127.0.0.1
#    volumes:
#      - ./data/gitlab/git-data:/var/opt/gitlab/git-data
#      - ./config/gitlab:/etc/gitlab
#      - ./data/gitlab:/var/opt/gitlab
#      - ./logs:/var/log/gitlab
    networks:
      - gitlab
#  gitlab-runner:
#    image: gitlab/gitlab-runner:v12.9.0
#    container_name: gitlab-runner-0
#    restart: unless-stopped
#    depends_on:
#      - gitlab
#    volumes:
#      - ./runner/config.toml:/etc/gitlab-runner/config.toml
#      - /var/run/docker.sock:/var/run/docker.sock
#    networks:
#      - gitlab

networks:
  gitlab:
