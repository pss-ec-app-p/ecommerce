echo " please enter the pat token"
read token
cat ~/.ssh/id_rsa.pub
if [ $? -eq 0 ]
then 
 echo "ssh keys are present"
else
echo "ssh keys are not present so please generated ssh keys using command"
ssh-keygen -t rsa
fi

sshkeys=`cat ~/.ssh/id_rsa.pub`

if [ $? -eq 0 ]
then 
echo "copy ssh keys to GitHub"
curl -X POST -H "content-type: application/json" -d "{\"title\":\"SSHKEYS\",\"key\":\"$sshkeys\"}" "https://api.github.com/user/keys?accesss_token=$token"
if [ $? -eq 0 ]
then
echo "successfully copied"
exit 0
else
echo "failed"
exit 1
fi
else
echo "failure in generating the keys"
exit 1
fi

