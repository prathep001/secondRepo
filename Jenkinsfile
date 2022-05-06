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
			tool name: 'MATLAB', type: 'matlab'
            steps {
                dir('TestScripts') {
					runMATLABCommand 'testScriptAutotrans'
				}
            }
        }
    }
}
