#!groovy
@Library('jenkins-shared-library')
import com.sivalabs.JenkinsMavenLib

def dockerUsername = 'sivaprasadreddy'
def dockerImageName = 'bookmarks-ui'

def project = new JenkinsMavenLib(this, scm, env, params, currentBuild)

node {

    try {
        stage("Checkout") {
            project.checkout()
        }
        stage("Build") {
            project.runTests()
        }
        stage("Publish Docker Image") {
            project.buildSpringBootDockerImage(dockerUsername, dockerImageName)
            if(env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') {
                def tags = ["latest"]
                project.publishDockerImage(dockerUsername, dockerImageName, tags)
            }
        }
    }
    catch(err) {
        echo "ERROR: ${err}"
        currentBuild.result = currentBuild.result ?: "FAILURE"
    }
}
