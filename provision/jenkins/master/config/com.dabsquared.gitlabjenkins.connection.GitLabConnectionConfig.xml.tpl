<?xml version='1.1' encoding='UTF-8'?>
<com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig plugin="gitlab-plugin@1.5.13">
  <useAuthenticatedEndpoint>false</useAuthenticatedEndpoint>
  <connections>
    <com.dabsquared.gitlabjenkins.connection.GitLabConnection>
      <name>gitlab</name>
      <url>{{ .GITLAB_URL }}</url>
      <apiTokenId></apiTokenId>
      <clientBuilder class="com.dabsquared.gitlabjenkins.gitlab.api.impl.AutodetectGitLabClientBuilder">
        <id>autodetect</id>
        <ordinal>0</ordinal>
      </clientBuilder>
      <ignoreCertificateErrors>true</ignoreCertificateErrors>
      <connectionTimeout>10</connectionTimeout>
      <readTimeout>10</readTimeout>
    </com.dabsquared.gitlabjenkins.connection.GitLabConnection>
  </connections>
</com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig>
