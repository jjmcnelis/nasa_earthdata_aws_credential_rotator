# nasa_earthdata_aws_credential_rotator
Retrieve temporary credentials provisioned by NASA Earthdata for s3 bucket access and store them in your local credentials file.

An alias like this one can simplify the usage of [`awsedl.sh`](awsedl.sh).

```bash
alias awsedl='sh awsedl.sh > ./creds && mv ./creds ~/.aws/credentials'
```

(Warning: this recklessly overwrites your existing credentials file with outputs from `awsedl.sh`.)
