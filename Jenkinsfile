pipeline {
  agent {
    node {
      label 'master'
    }

  }
  stages {
    stage('Build image') {
      post {
        success {
          script {
            G_teststatus = "success"
          }


        }

        failure {
          script {
            G_teststatus = "failure"
          }


        }

      }
      steps {
        script {
          sshagent (credentials: [G_gitcred]) {
            withEnv(['DOCKER_BUILDKIT=1']) {
              staging_app_image = docker.build(
                "test_docker_target:${dockerTag}",
                "--label 'git-commit=${GIT_COMMIT}' --ssh default --build-arg FEATURES='${BUILD_FEATURES}' ."
                // "--label 'git-commit=${GIT_COMMIT}' --ssh default --target builder-test --build-arg FEATURES='${BUILD_FEATURES}' ."
              )
            }
          }
        }

      }
    }
  }
  environment {
    my_project_name = '${PROJECT_NAME}'
  }
  options {
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10'))
    disableConcurrentBuilds()
    parallelsAlwaysFailFast()
  }
  parameters {
    booleanParam(defaultValue: false, description: 'Promote image built to be used as latest', name: 'FORCE_PROMOTE_LATEST')
  }
}