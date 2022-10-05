# nasa_earthdata_aws_credential_rotator
Retrieve temporary credentials provisioned by NASA Earthdata for s3 bucket access and store them in your local credentials file.

An alias like this one can simplify the usage of [`awsedl.sh`](awsedl.sh). (This requires that you put the script in ~/.local/bin directory and chmod it, if necessary.)

```bash
alias awsedl='touch ~/.aws/credentials && mv ~/.aws/credentials ~/.aws/credentials.bak && sh ~/.local/bin/awsedl.sh ~/.aws/credentials.bak > ~/.aws/credentials && echo "# New AWS tokens $(grep edl ~/.aws/credentials -A 6 | grep expiration | sed 's/#//g')"'
```

Warning: this recklessly overwrites your existing credentials file with outputs from `awsedl.sh`! (But it stores a backup in ~/.aws/credentials.bak.)
