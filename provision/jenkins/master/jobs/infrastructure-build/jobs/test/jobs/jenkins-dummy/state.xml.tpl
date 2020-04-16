<?xml version='1.1' encoding='UTF-8'?>
<jenkins.branch.MultiBranchProject_-State plugin="branch-api@2.5.5">
  <sourceActions>
    <entry>
      <string>infrastructure-build.test.jenkins-dummy</string>
      <list>
        <jenkins.plugins.git.GitRemoteHeadRefAction plugin="git@4.2.2">
          <remote>{{ .GITLAB_URL }}/infrastructure-build/jenkins-dummy.git</remote>
          <name>master</name>
        </jenkins.plugins.git.GitRemoteHeadRefAction>
      </list>
    </entry>
  </sourceActions>
</jenkins.branch.MultiBranchProject_-State>
