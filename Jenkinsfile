#!groovy
// Declarative //
pipeline {
    agent any
	
	parameters  { 
		FileEditType = ''
		ChangedFilePath = ''
	}
    stages {
		
        stage('Checkout') {
            steps {
                echo 'Checkout completed'
            }
        }

        stage('Filter') {
			
            steps {
				script {
					String FileEditTypeLocal = " "
					String ChangedFilePathLocal = " "
					(FileEditTypeLocal, ChangedFilePathLocal) = getFilteredFiles()
					echo "After checkout Local Var"
					echo "FileEditTypeLocal is ${FileEditTypeLocal}"
					echo "ChangedFilePathLocal is ${ChangedFilePathLocal}"
					params.FileEditType = FileEditTypeLocal
					params.ChangedFilePath = ChangedFilePathLocal
					echo "After checkout Environment Var"
					echo "FileEditTypeLocal is ${params.FileEditType}"
					echo "ChangedFilePathLocal is ${params.ChangedFilePath}"
				}
				
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
