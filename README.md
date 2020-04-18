# infrastructure-build
Deploy a complete build platform as a foundation for your development
home laboratory.

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
binaries/artifacts you generate from your projects.
* `Jenkins`: Most popular CI/CD tool, to help you build, 
test and deploy your projects.
* `Gitlab`: A place to store your projects locally
* `Gradle plugins`: They provide your project with
 the foundation to integrate with the platform.
 
# Components not yet ready
* `Keycloak/LDAP`: Centralized authentication component
for the platform.
* `DNS server/Reverse proxy`: Components to help you
access the different components in the platform
with a simple local domain.
* `SSL`: To let you access the platform components
in a more secure manner.

# Configure it
The VM configuration is stored in the `config.json` file.
Ensure you give it enough resources, as it needs at least 5Gb
of RAM and 2 CPU's to start up flawlessly.

# Run it
Just execute `./redeploy.sh`, but watch out, this will 
delete any previous state and data of your platform.

Access the various components through their specific urls:
* Jenkins: `http://jenkins.dev.local` or `http://192.168.1.100:8080`
* Artifactory: `http://artifactory.dev.local` or `http://192.168.1.100:8081`
* GitLab: `http://gitlab.dev.local` or `http://192.168.1.100:8082`


# Artifactory
Username: `admin`\
Password: `passw0rd`

#Jenkins

#Gitlab
Username: `root`\
Password: `gitlabroot`
