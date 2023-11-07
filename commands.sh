# Generate and show the ssh keys
ssh-keygen -t rsa
cat /home/odl_user/.ssh/id_rsa.pub

# Clone and enter to the repository
git clone git@github.com:dcquinche/agile-azure-project-CI-CD.git
cd agile-azure-project-CI-CD

# Create, activate and configure a virtual environment
python3 -m venv ~/.pred
source ~/.pred/bin/activate
make all

# Create a web app and make it a prediction
az webapp up -n agilewebapp243371 -l westeurope --resource-group Azuredevops
chmod +x make_predict_azure_app.sh
./make_predict_azure_app.sh
az webapp log tail

# Create, configure and activate an agent for the pipeline
curl -O https://vstsagentpackage.azureedge.net/agent/3.227.2/vsts-agent-linux-x64-3.227.2.tar.gz
mkdir myagent && cd myagent
tar zxvf ../vsts-agent-linux-x64-3.227.2.tar.gz
./config.sh
./run.sh