# nasa_earthdata_aws_credential_rotator
Retrieve temporary credentials provisioned by NASA Earthdata for s3 bucket access and store them in your local credentials file.

An alias like this one can simplify the usage of [`awsedl.sh`](awsedl.sh).

```bash
alias awsedl='touch ~/.aws/credentials && mv ~/.aws/credentials ~/.aws/credentials.bak && sh ~/.local/bin/awsedl.sh ~/.aws/credentials.bak > ~/.aws/credentials && echo "$(grep edl ~/.aws/credentials -A 6 | grep expiration)"'
```

Important notes about the alias example above:
* It expects `awsedl.sh` to live inside `~/.local/bin`.
* Use caution! The file at `~/.aws/credentials` will be replaced; however, the alias makes a backup of the previous version at `~/.aws/credentials.bak`.
