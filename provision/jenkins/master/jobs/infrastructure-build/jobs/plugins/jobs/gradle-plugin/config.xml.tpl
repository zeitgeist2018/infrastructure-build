<?xml version="1.0" encoding="UTF-8"?><org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject>
    <properties/>
    <folderViews class="jenkins.branch.MultiBranchProjectViewHolder">
        <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
    </folderViews>
    <healthMetrics>
        <com.cloudbees.hudson.plugins.folder.health.WorstChildHealthMetric>
            <nonRecursive>false</nonRecursive>
        </com.cloudbees.hudson.plugins.folder.health.WorstChildHealthMetric>
    </healthMetrics>
    <icon class="jenkins.branch.MetadataActionFolderIcon">
        <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
    </icon>
    <triggers/>
    <sources class="jenkins.branch.MultiBranchProject$BranchSourceList">
        <data>
            <jenkins.branch.BranchSource>
                <source class="jenkins.plugins.git.GitSCMSource">
                    <id>infrastructure-build.plugins.gradle-plugin</id>
                    <remote>{{ .GITLAB_URL }}/infrastructure-build/gradle-plugin.git</remote>
                    <credentialsId/>
                    <includes>master feature/*</includes>
                    <excludes/>
                    <ignoreOnPushNotifications>false</ignoreOnPushNotifications>
                </source>
                <strategy class="jenkins.branch.DefaultBranchPropertyStrategy">
                    <properties class="empty-list"/>
                </strategy>
            </jenkins.branch.BranchSource>
        </data>
        <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
    </sources>
    <factory class="org.jenkinsci.plugins.workflow.multibranch.WorkflowBranchProjectFactory">
        <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
    </factory>
    <orphanedItemStrategy class="com.cloudbees.hudson.plugins.folder.computed.DefaultOrphanedItemStrategy">
        <pruneDeadBranches>true</pruneDeadBranches>
        <daysToKeep>1</daysToKeep>
        <numToKeep>-1</numToKeep>
    </orphanedItemStrategy>
</org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject>
