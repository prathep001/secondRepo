#!groovy
// Declarative //
pipeline {
    agent any
	
	environment { 
		FileEditType = ''
		ChangedFilePath = ''
	}
    stages {
		
        stage('Checkout') {
            steps {
                script {
                    echo 'Checkout completed'
                }

            }
        }

        stage('Filter') {
			
            steps {
				script {
					(FileEditType, ChangedFilePath) = getFilteredFiles()					
					echo "After checkout Environment Var"
					echo "FileEditTypeLocal is ${FileEditType}"
					echo "ChangedFilePathLocal is ${ChangedFilePath}"
                    echo 'Filter completed'
				}
				
            }
        }
		
		stage('MATLAB command test') {
            steps {
				tool name: 'MATLAB', type: 'matlab'
                script{
                    dir('TestScripts') {
					    echo "In Command Test Var"
					    echo "FileEditTypeLocal is ${FileEditType}"
					    echo "ChangedFilePathLocal is ${ChangedFilePath}"
                        def scriptText = "testScriptAutotrans('${FileEditType}','${ChangedFilePath}')"
                        echo "${scriptText}"
					    runMATLABCommand scriptText
				    }
                }
            }
        }
    }
}

@NonCPS
def getFilteredFiles(){
	def changeLogSets = currentBuild.changeSets
	def changeTypeString = ""
	def changePathString = ""
	for (int i = 0; i < changeLogSets.size(); i++) {
		def entries = changeLogSets[i].items
		for (int j = 0; j < entries.length; j++) {
			def entry = entries[j]
			echo "${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}"
			def files = new ArrayList(entry.affectedFiles)
			for (int k = 0; k < files.size(); k++) {
				def file = files[k]
				if (changeTypeString) {
					changeTypeString += ","
		        }
				if (changePathString) {
					changePathString += ","
		        }
				changeTypeString += "  ${file.editType.name}"
				changePathString += "  ${file.path}"
			}
		}
	}
	return [changeTypeString, changePathString]
}
