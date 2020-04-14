# infrastructure-build
Deploy a complete build platform as a foundation for your development

# Description
The idea behind this project is to provide an easy way
to deploy a complete build platform, that you can use
either to learn the components that comprise the platform 
itself, or work on other projects using it.
All the components in the platform are integrated
with each other, and detailed instructions on how
to work with this platform will be provided.

# Components ready
* `JFrog Artifactory`: A place to store and manage the
binaries/artifacts you generate from your projects

# Components not yet ready
* `Gradle plugins`: They provide your project with
 the foundation to integrate with the platform.
* `Jenkins`: Most popular CI/CD tool, to help you build, 
test and deploy your projects.
* `Gitlab`: A place to store your projects locally

# Configure it
The VM configuration is stored in the `config.json` file.
# Run it
Just execute `./redeploy.sh`.

Access the various components through their specific urls:
* Jenkins: `http://192.168.1.100:8080`
* Artifactory: `http://192.168.1.100:8081`
* GitLab: `http://192.168.1.100:8082`


# Artifactory
Username: `admin`\
Password: `passw0rd`

#Jenkins

#Gitlab
Username: `root`\
Password: `gitlabroot`
