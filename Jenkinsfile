pipeline {
    agent any
    environment {
        NETLIFY_SITE_ID = 'ea56ac48-4221-4d69-9323-521fcf5f9928'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
    }

    stages {

        stage('Build') {
            agent {
                docker {
                    image 'node:18'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    node --version
                    npm --version
                    npm ci
                    npm run build
                '''
            }
        }
        stage('run tests'){
            parallel {
                        stage('Test') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    test -f build/index.html
                    npm test
                '''
            }
        }
/*
        stage('E2E') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.60.0-noble'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm install serve
                    node_modules/.bin/serve -s build &
                    #npx serve -s build &
                    sleep 10
                    npx playwright test --reporter=html
                '''
            }
        } */

            }

        }
                stage('deploy') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm install netlify-cli
                    node_modules/.bin/netlify --version
                     node_modules/.bin/netlify status
                     node_modules/.bin/netlify deploy --dir=build --prod
                '''
            }
        }


    }

    post {
        always {
            junit allowEmptyResults: true,
                  testResults: 'jest-results/junit.xml'
        }
    }
}