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
  <clouds/>
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
