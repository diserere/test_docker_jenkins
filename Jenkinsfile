// @Library('infrastructure-jenkins-shared-library@master')_


G_gitcred = "diserere_on_github"
G_promoted_branch = 'origin/feature-dev'
G_buildstatus = 'NotSet'
G_teststatus = 'NotSet'

// dockerTag = ${PROJECT_NAME}-${GIT_COMMIT}-${BUILD_ID}

BUILD_FEATURES = "ci_run"

pipeline {
    agent {
        node {label 'master'}
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
                    // dockerTag = ${PROJECT_NAME}-${GIT_COMMIT}-${BUILD_ID}
                    sshagent (credentials: [G_gitcred]) {
                        withEnv(['DOCKER_BUILDKIT=1']) {
                            staging_app_image = docker.build(
                                // "test_docker_target:${BUILD_ID}-${GIT_COMMIT}",
                                "test_docker_target",
                                "--label 'git-commit=${GIT_COMMIT}' --ssh default --build-arg FEATURES='${BUILD_FEATURES}' ."
                                // "--label 'git-commit=${GIT_COMMIT}' --ssh default --target builder-test --build-arg FEATURES='${BUILD_FEATURES}' ."
                            )
                        }
                    }
                }
            }
            post {
                success { script{ G_buildstatus = "success" } }
                failure { script{ G_buildstatus = "failure" } }
            }
        }

        stage ("Test image") {
            steps {
                script {
                    staging_app_image.inside("-it --entrypoint ''") { 
                    // staging_app_image.inside { 
                    // staging_app_image.inside("-it --entrypoint ''", "/bin/bash") { 
                    // staging_app_image.withRun("-it --entrypoint ''", "/bin/bash") { 
                    // staging_app_image.withRun("-it") { 
                    // staging_app_image.withRun("-it", "-h") { 
                    // staging_app_image.run("-it --rm", "-fake") { 
                    // staging_app_image.inside("-it --rm", "-fake") { 
                    // staging_app_image.inside { 
                        // sh 'pwd'
                        // sh 'ls -la'
                        // sh 'echo "inside container"'
                        // sh "echo 'BUILD_FEATURES: ${BUILD_FEATURES}'"
                        // sh 'netstat -V'
                        sh 'which netstat'
                        // sh 'echo test passed'
                    }
                }
            }
        }


    }



}

