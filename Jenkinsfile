pipeline {
    agent any
    stages {
		
        stage('Checkout') {
            steps {
                echo 'Checkout completed'
            }
        }
		
        stage('Filter') {
            steps {
                echo 'Filter completed'
            }
        }
		
		stage('MATLAB command test') {
            steps {
				tool name: 'MATLAB', type: 'matlab'
                dir('TestScripts') {
					runMATLABCommand 'testScriptAutotrans'
				}
            }
        }
    }
}
