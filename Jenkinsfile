pipeline {
    agent any
    environment {
         PATH = "${env.PATH};C:\\Users\\Harsh\\Desktop\\terraform_1.11.3_windows_386"
        AZURE_CREDENTIALS_ID = 'azure-service-principal'
        RESOURCE_GROUP = 'rg-dot-resource'
        APP_SERVICE_NAME = 'dot-app-service'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/harshit2503/Helloweb.git'
            }
        }

        stage('Build') {
            steps {
                bat 'dotnet restore' // it install all nuget packages which are present in dependicies packages in vs 
                bat 'dotnet build --configuration Release'
                bat 'dotnet publish -c Release -o ./publish' // it create a two folder bin(final output) and obj(temporary) 
            }
        }

        stage('Test Terraform') {
            steps {
                dir('terraform-dotnet') {
                    bat 'terraform --version'
                }
            }
        }

        stage("terraform setup") {
            steps {
                dir("terraform-dotnet") {
                    withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat "az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID"
                    }
                    bat 'terraform init'
                    bat 'terraform plan -out=tfplan'
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat "az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID"
                    bat "powershell Compress-Archive -Path ./publish/* -DestinationPath ./publish.zip -Force"
                    bat "az webapp deploy --resource-group $RESOURCE_GROUP --name $APP_SERVICE_NAME --src-path ./publish.zip --type zip"
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
