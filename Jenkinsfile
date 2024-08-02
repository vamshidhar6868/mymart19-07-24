pipeline{
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-cred')
        AWS_SECRET_ACCESS_KEY = credentials('aws-cred')
    }
    stages {
        stage('aws'){
            steps  {

     withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    // some block
      }
   }
 }           

        stage('test'){

      steps  {
            sh '''
            terraform init
            terraform plan -out=test.tfplan
            terraform apply test.tfplan
            '''
            }
        }
    }
}
