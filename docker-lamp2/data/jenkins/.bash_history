ssh -l root lamp-web
ssh -l lamp-web root
exit
cd /var/jenkins_home/
ls -al
mkdir .ssh
cd .ssh
ssh-keygen -lf ./id_rsa.pub
ssh-keygen -t rsa -b 4096
ls -al
exit
cd /var/jenkins_home/.ssh
ls -al
chgrp jenkins id_rsa
ls -al
exit
