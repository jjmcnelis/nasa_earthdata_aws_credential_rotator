# nasa_earthdata_aws_credential_rotator
A shell script to refresh temporary AWS credentials provisioned by NASA Earthdata

Simplify usage of [`awsedl.sh`](awsedl.sh) with an alias like the one below, which inserts or replaces EDL-managed AWS credentials within the user's local credentials file, `~/.aws/credentials`.

```bash
alias awsedl='sh awsedl.sh > ./creds && mv ./creds ~/.aws/credentials'
```

Warning: this alias recklessly overwrites your existing credentials file with the outputs of `awsedl.sh`.
