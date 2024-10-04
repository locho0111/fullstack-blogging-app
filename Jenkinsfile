pipeline {
    agent any
    tools {
        jdk "JAVA_17"
        maven "MAVEN_3"
        // sonarQube "sonar-scanner"
    }
    
    environment {
        SCANNER_HOME = tool "sonar-scanner"
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "34.205.140.114:8081"
        NEXUS_REPOSITORY = "maven-nexus-repo"
        NEXUS_CREDENTIAL_ID = "NEXUS_CRED"
    }
    
    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', credentialsId: 'GIT_CRED', url: 'https://github.com/locho0111/fullstack-blogging-app-CI-CD.git'
            }
        }
        
        // stage('Build') {
        //     steps {
        //         sh "mvn compile"
        //     }
        // }
        
        // stage('Test') {
        //     steps {
        //         sh "mvn test"
        //     }
        // }
        
        // stage('Trivy scan') {
        //     steps {
        //         sh "trivy fs -f table -o fs.html ."
        //     }
        // }
        
        // stage("SonarQube analysis"){
        //     steps{
        //         withSonarQubeEnv('SONAR_SERVER'){
        //             sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Blogging-app -Dsonar.projectKey=Blogging-app\
        //                     -Dsonar.java.binaries=target'''
        //         }
        //     }
        // }
        
        stage('Build artifact') {
            steps {
                sh "mvn package"
            }
        }
        
        // stage("Publish to Nexus Repository Manager") {
        //     steps {
        //         script {
        //             pom = readMavenPom file: "pom.xml";
        //             filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
        //             echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
        //             artifactPath = filesByGlob[0].path;
        //             artifactExists = fileExists artifactPath;
        //             if(artifactExists) {
        //                 echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
        //                 nexusArtifactUploader(
        //                     nexusVersion: NEXUS_VERSION,
        //                     protocol: NEXUS_PROTOCOL,
        //                     nexusUrl: NEXUS_URL,
        //                     groupId: pom.groupId,
        //                     version: pom.version,
        //                     repository: NEXUS_REPOSITORY,
        //                     credentialsId: NEXUS_CREDENTIAL_ID,
        //                     artifacts: [
        //                         [artifactId: pom.artifactId,
        //                         classifier: '',
        //                         file: artifactPath,
        //                         type: pom.packaging],
        //                         [artifactId: pom.artifactId,
        //                         classifier: '',
        //                         file: "pom.xml",
        //                         type: "pom"]
        //                     ]
        //                 );
        //             } else {
        //                 error "*** File: ${artifactPath}, could not be found";
        //             }
        //         }
        //     }
            
        // }
        
        stage('Docker build') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'DOCKER_CRED', toolName: 'DOCKER') {
                        sh "docker build -t rickho0111/blog-app:latest ."
                    }
                }
                
            }
        }
        
        stage('Trivy Image scan') {
            steps {
                sh "trivy image -f table -o image.html rickho0111/blog-app:latest"
            }
        }
        
        stage('Docker push') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'DOCKER_CRED', toolName: 'DOCKER') {
                        sh "docker push rickho0111/blog-app:latest "
                    }
                }
                
            }
        }
    }
}
