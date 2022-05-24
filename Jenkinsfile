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
                echo 'Checkout completed'
            }
        }

        stage('Filter') {
			
            steps {
				script {
					(FileEditType, ChangedFilePath) = getFilteredFiles()					
					echo "After checkout Environment Var"
					echo "FileEditTypeLocal is ${FileEditType}"
					echo "ChangedFilePathLocal is ${ChangedFilePath}"
					def existFlag = fileExists('changeDetailsText.txt')
					if (existFlag){
						echo "File exists"
						echo "${existFlag}"
						
					}
					def a=pwd()
					echo "${a}"
					filename = "changeDetailsText.txt";
					writeFile(file: filename, text: '${FileEditType} \n ${ChangedFilePath}')
					sh 'ls -l'
				}
				
            }
        }
		
		stage('MATLAB command test') {
            steps {
				tool name: 'MATLAB', type: 'matlab'
                dir('TestScripts') {
					echo "In Command Test Var"
					echo "FileEditTypeLocal is ${FileEditType}"
					echo "ChangedFilePathLocal is ${ChangedFilePath}"
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
