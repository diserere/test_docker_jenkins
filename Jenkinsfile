// @Library('infrastructure-jenkins-shared-library@master')_


G_gitcred = "diserere_on_github"
G_promoted_branch = 'origin/feature-dev'
G_buildstatus = 'NotSet'
G_teststatus = 'NotSet'

dockerTag = "${PROJECT_NAME}-${GIT_COMMIT}-${BUILD_ID}"

BUILD_FEATURES = "ci_run"

pipeline {
    agent {
        any
    }
    parameters {
        booleanParam (
            defaultValue: false,
            description: 'Promote image built to be used as latest',
            name : 'FORCE_PROMOTE_LATEST'
        )
    }

        options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
        disableConcurrentBuilds()
        parallelsAlwaysFailFast()
    }
    stages {
        stage ('Build image') {
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
            post {
                success { script{ G_teststatus = "success" } }
                failure { script{ G_teststatus = "failure" } }
            }
        }


    }



}

