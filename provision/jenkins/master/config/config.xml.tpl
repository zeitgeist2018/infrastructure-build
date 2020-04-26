<?xml version='1.1' encoding='UTF-8'?>
<hudson>
  <disabledAdministrativeMonitors/>
  <version>2.232</version>
  <installStateName>RUNNING</installStateName>
  <numExecutors>2</numExecutors>
  <mode>NORMAL</mode>
  <useSecurity>true</useSecurity>
  <authorizationStrategy class="hudson.security.AuthorizationStrategy$Unsecured"/>
  <securityRealm class="hudson.security.SecurityRealm$None"/>
  <disableRememberMe>false</disableRememberMe>
  <projectNamingStrategy class="jenkins.model.ProjectNamingStrategy$DefaultProjectNamingStrategy"/>
  <workspaceDir>${ITEM_ROOTDIR}/workspace</workspaceDir>
  <buildsDir>${ITEM_ROOTDIR}/builds</buildsDir>
  <jdks/>
  <viewsTabBar class="hudson.views.DefaultViewsTabBar"/>
  <myViewsTabBar class="hudson.views.DefaultMyViewsTabBar"/>
  <clouds>
    <com.nirima.jenkins.plugins.docker.DockerCloud plugin="docker-plugin@1.2.0">
      <name>docker</name>
      <templates>
        <com.nirima.jenkins.plugins.docker.DockerTemplate>
          <configVersion>2</configVersion>
          <labelString>java8</labelString>
          <connector class="io.jenkins.docker.connector.DockerComputerSSHConnector">
            <sshKeyStrategy class="io.jenkins.docker.connector.DockerComputerSSHConnector$InjectSSHKey">
              <user>jenkins</user>
            </sshKeyStrategy>
            <port>22</port>
            <jvmOptions></jvmOptions>
            <javaPath></javaPath>
            <prefixStartSlaveCmd></prefixStartSlaveCmd>
            <suffixStartSlaveCmd></suffixStartSlaveCmd>
          </connector>
          <remoteFs>/home/jenkins</remoteFs>
          <instanceCap>5</instanceCap>
          <mode>NORMAL</mode>
          <retentionStrategy class="com.nirima.jenkins.plugins.docker.strategy.DockerOnceRetentionStrategy">
            <idleMinutes>2</idleMinutes>
          </retentionStrategy>
          <dockerTemplateBase>
            <image>{{ .ARTIFACTORY_JCR_DOMAIN }}/docker-local/jenkins-agent-java</image>
            <pullCredentialsId></pullCredentialsId>
            <dockerCommand></dockerCommand>
            <hostname></hostname>
            <user></user>
            <extraGroups class="empty-list"/>
            <dnsHosts/>
            <network></network>
            <volumes/>
            <volumesFrom2/>
            <devices/>
            <environment/>
            <bindPorts></bindPorts>
            <bindAllPorts>false</bindAllPorts>
            <privileged>false</privileged>
            <tty>false</tty>
            <extraHosts class="empty-list"/>
          </dockerTemplateBase>
          <removeVolumes>false</removeVolumes>
          <pullStrategy>PULL_ALWAYS</pullStrategy>
          <pullTimeout>300</pullTimeout>
          <nodeProperties class="empty-list"/>
          <disabled>
            <disabledByChoice>false</disabledByChoice>
          </disabled>
        </com.nirima.jenkins.plugins.docker.DockerTemplate>
      </templates>
      <dockerApi>
        <dockerHost plugin="docker-commons@1.16">
          <uri>tcp://{{ .HOST }}:{{ .DOCKER_API_PORT }}</uri>
        </dockerHost>
        <connectTimeout>60</connectTimeout>
        <readTimeout>60</readTimeout>
      </dockerApi>
      <containerCap>5</containerCap>
      <exposeDockerHost>false</exposeDockerHost>
      <disabled>
        <disabledByChoice>false</disabledByChoice>
      </disabled>
    </com.nirima.jenkins.plugins.docker.DockerCloud>
  </clouds>
  <quietPeriod>0</quietPeriod>
  <scmCheckoutRetryCount>0</scmCheckoutRetryCount>
  <views>
    <hudson.model.AllView>
      <owner class="hudson" reference="../../.."/>
      <name>all</name>
      <filterExecutors>false</filterExecutors>
      <filterQueue>false</filterQueue>
      <properties class="hudson.model.View$PropertyList"/>
    </hudson.model.AllView>
  </views>
  <primaryView>all</primaryView>
  <slaveAgentPort>50000</slaveAgentPort>
  <label></label>
  <crumbIssuer class="hudson.security.csrf.DefaultCrumbIssuer">
    <excludeClientIPFromCrumb>false</excludeClientIPFromCrumb>
  </crumbIssuer>
  <nodeProperties/>
  <globalNodeProperties>
    <org.jenkinsci.plugins.envinject.EnvInjectNodeProperty plugin="envinject@2.3.0">
      <unsetSystemVariables>true</unsetSystemVariables>
    </org.jenkinsci.plugins.envinject.EnvInjectNodeProperty>
    <hudson.slaves.EnvironmentVariablesNodeProperty>
      <envVars serialization="custom">
        <unserializable-parents/>
        <tree-map>
          <default>
            <comparator class="hudson.util.CaseInsensitiveComparator"/>
          </default>
          <int>2</int>
          <string>ARTIFACTORY_URL</string>
          <string>{{ .ARTIFACTORY_URL }}</string>
          <string>GIT_URL</string>
          <string>{{ .GITLAB_URL }}</string>
        </tree-map>
      </envVars>
    </hudson.slaves.EnvironmentVariablesNodeProperty>
  </globalNodeProperties>
  <noUsageStatistics>true</noUsageStatistics>
</hudson>
