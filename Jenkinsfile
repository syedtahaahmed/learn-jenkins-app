pipeline {
    agent any
    stages {
        stage('build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }
        stage('Test'){
                        agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
           steps {
            echo 'TEST stage'
            sh '''test -f build/index.html
                npm test
            '''
           }
           post{
            always{
               junit 'test-results/junit.xml' 
            }
           }
        }
                stage('E2E'){
                        agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.60.0-noble'
                    reuseNode true
                }
            }
           steps {
            echo 'TEST stage'
            sh '''npm install -g serve
                serve -s build
                npx playwright test
            '''
           }
           post{
            always{
               junit 'test-results/junit.xml' 
            }
           }
        }
    }
}
