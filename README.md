# nasa_earthdata_aws_credential_rotator
Retrieve temporary credentials provisioned by NASA Earthdata for s3 bucket access and store them in your local credentials file.

### Usage

The shell script will exit immediately if local file ~/.netrc does not contain 'urs.earthdata.nasa.gov'.

```bash
$ awsedl <1: credentials file, e.g. '~/.aws/credentials'> \
         <2: nasa daac s3 credentials endpoint, e.g. 'https://archive.podaac.earthdata.nasa.gov/s3credentials'> \
         <3: local aws profile name/alias, e.g. 'edl'>
```
s3 credentials for the PO.DAAC are installed by default. The default profile name is 'edl'.
```
$ awsedl
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

Redirect the stdout to a file and replace yours in ~/.aws/credentials or elsewhere.

**Install script inside your ec2 instance:**

```bash
# a) create ~/.local/bin directory, if necessary, and add it to user $PATH variable:
mkdir -p ~/.local/bin/ && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && PATH="$HOME/.local/bin:${PATH}"
# b) download the awsedl script, and c) make it executable:
curl -s -o ~/.local/bin/awsedl https://raw.githubusercontent.com/jjmcnelis/nasa_earthdata_aws_credential_rotator/main/awsedl.sh && \
  chmod +x ~/.local/bin/awsedl
```

**Alias to simplify token refresh inside your ~/.aws/credentials file:**

```bash
alias awsedld="mkdir -p ~/.aws && touch ~/.aws/credentials && mv ~/.aws/credentials ~/.aws/credentials.bak && bash ~/.local/bin/awsedl ~/.aws/credentials.bak | sed '/^$/d' > ~/.aws/credentials && grep edl ~/.aws/credentials -A 6 | grep expiration"
```

Important notes about the alias example above:
* Existing profiles are retained in the new ~/.aws/credentials file. Use at your own risk. 
* It replaces`~/.aws/credentials` and keeps a backup of the previous version at `~/.aws/credentials.bak`.
* It expects `awsedl` to live inside `~/.local/bin`.

**Next steps for user:**

Provide the 'edl' profile when access earthdata/podaac s3 buckest, e.g. sync files from s3 using aws cli like this:

```bash
aws --profile edl s3 sync s3://podaac-ops-cumulus-protected/JASON_CS_S6A_L2_ALT_LR_STD_OST_NRT_F/ ./
```
