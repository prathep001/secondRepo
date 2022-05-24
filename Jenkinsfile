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
				prev_merge=$(git log |grep -C1 Merge | grep commit |head -n1 | awk {'print $2'})
				commit=$(git log |head -n 1  | awk {'print $2'})
				git diff --name-only $prev_merge $commit
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
