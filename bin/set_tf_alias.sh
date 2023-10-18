#!/usr/bin/env bash

# Check if the alias already exists in the .bash_profile
grep -q 'alias tf="terraform"' ~/.bash_profile
grep -q 'alias tfi="terraform init"' ~/.bash_profile
grep -q 'alias tfp="terraform plan"' ~/.bash_profile
grep -q 'alias tfa="terraform apply --auto-approve"' ~/.bash_profile
grep -q 'alias tfd="terraform destroy --auto-approve"' ~/.bash_profile

# $? is a special variable in bash that holds the exit status of the last command executed
if [ $? -ne 0 ]; then
    # If the alias does not exist, append it
    echo 'alias tf="terraform"' >> ~/.bash_profile
    echo 'alias tfi="terraform init"'  >> ~/.bash_profile
    echo 'alias tfp="terraform plan"' >> ~/.bash_profile
    echo 'alias tfa="terraform apply --auto-approve"' >> ~/.bash_profile
    echo 'alias tfd="terraform destroy --auto-approve"' >> ~/.bash_profile
    echo "Alias added successfully."
source ~/.bash_profile
else
    # Inform the user if the alias already exists
    echo "Alias already exists in .bash_profile."
fi

# Optional: source the .bash_profile to make the alias available immediately
source ~/.bash_profile