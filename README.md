# nasa_earthdata_aws_credential_rotator
Retrieve temporary credentials provisioned by NASA Earthdata for s3 bucket access and store them in your local credentials file.

### Usage

The shell script will exit immediately if local file ~/.netrc does not contain 'urs.earthdata.nasa.gov'.

```bash
sh awsedl.sh <1: credentials file, e.g. '~/.aws/credentials'> \
             <2: nasa daac s3 credentials endpoint, e.g. 'https://archive.podaac.earthdata.nasa.gov/s3credentials'> \
             <3: local aws profile name/alias, e.g. 'edl'>
```
s3 credentials for the PO.DAAC are installed by default. The default profile name is 'edl'.
```
$ ./awsedl.sh
```

yields

```
...
[edl]
output = json
region = us-west-2
aws_access_key_id = ...
aws_secret_access_key = ......
aws_session_token = ..................
#expiration = 2022-10-05 02:54:08+00:00
```

Redirect the stdout to a file and replace yours in ~/.aws/credentials or elsewhere. All profiles are retained in the output.

The tokens store for the 'edl' profile will expire periodically. Give the profile name as an argument when using s3 apis, e.g. sync files from a bucket with aws cli like this:

```bash
aws --profile edl s3 sync s3://podaac-ops-cumulus-protected/JASON_CS_S6A_L2_ALT_LR_STD_OST_NRT_F/ ./
```

**Alias the script to simplify usage:**

```bash
alias awsedl='touch ~/.aws/credentials && mv ~/.aws/credentials ~/.aws/credentials.bak && sh ~/.local/bin/awsedl.sh ~/.aws/credentials.bak > ~/.aws/credentials && echo "$(grep edl ~/.aws/credentials -A 6 | grep expiration)"'
```

Important notes about the alias example above:
* Use at your own risk. 
* It replaces`~/.aws/credentials` and keeps a backup of the previous version at `~/.aws/credentials.bak`.
* It expects `awsedl.sh` to live inside `~/.local/bin`.
