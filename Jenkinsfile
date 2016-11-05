node("docker"){
  deleteDir()
  checkout scm
  sh "docker build -t invartam/phpservermon ."
  sh "docker push invartam/phpservermon"
  sh "docker rmi invartam/phpservermon"
}
