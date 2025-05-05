pipeline {
    agent {
        label 'ec2-private'
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Remove existing repository if exists
                    if (fileExists('/home/ubuntu/jenkins/workspace/node-js-loadbalancer/jenkins_nodejs_example')) {
                        sh '''
                            rm -rf /home/ubuntu/jenkins/workspace/node-js-loadbalancer/jenkins_nodejs_example
                        '''
                    }
                    // Clone the repository
                    sh '''
                        git clone -b rds_redis https://github.com/mahmoud254/jenkins_nodejs_example.git
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Ensure you're in the right directory
                    sh '''
                        cd /home/ubuntu/jenkins/workspace/node-js-loadbalancer/jenkins_nodejs_example
                        sudo docker build -t nodeapp-image .
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop and remove the existing container if it exists
                    sh '''
                        if [ $(sudo docker ps -a -q -f name=nodeapp) ]; then
                            sudo docker stop nodeapp
                            sudo docker rm nodeapp
                        fi
                    '''
                    
                    // Run the new container
                    sh '''
                        sudo docker run -d \
                            --name nodeapp \
                            -p 80:3000 \
                            -e RDS_HOSTNAME="terraform-20250409035711127900000001.c1m6yc0gq7a0.us-east-1.rds.amazonaws.com" \
                            -e RDS_USERNAME="megz" \
                            -e RDS_PASSWORD="AhmedMagdy" \
                            -e RDS_PORT=3306 \
                            -e REDIS_HOSTNAME="my-redis-cluster.lfkt1x.0001.use1.cache.amazonaws.com" \
                            -e REDIS_PORT=6379 \
                            nodeapp-image
                    '''
                }
            }
        }
    }
}
// RDS_PASSWORD should be saved as jenkins credentials 
//  ssh -i /var/jenkins_home/.ssh/megskey.pem -N -L 50001:10.0.1.8:22 ubuntu@3.85.183.90 -f
//  should be added to pipeline
// dont forgeet we map ~/.shh to /var/jenkins_home/.ssh in container 
// make sure about the permissions of the key and directory 

