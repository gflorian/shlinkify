# shlinkify
## Purpose
Shorten url using shlink via REST API.

The script uses a shlink instance from [shlink.io](https://shlink.io) running on your main domain example.com to shorten urls via the [REST API](https://shlink.io/documentation/api-docs/) from cli. The script is made for a multi-domain installation with two domains. Read more about [using multiple domains with shlink](https://shlink.io/documentation/advanced/multiple-domains/).

## How to
### Installation
`curl -O https://raw.githubusercontent.com/gflorian/shlinkify/main/shlink.sh`

`chmod u+x shlink.sh`

### Configuration
You need to change the values for DOMAIN1, DOMAIN2 and APIKEY at the beginning of the script. Read in the [manual](https://shlink.io/documentation/api-docs/authentication/) on how to generate an api key.

### Usage
You may just run shlink.sh and follow the prompts. The only mandatory input is the 'Lang URL' (long URL). All other inputs can be skipped with return. Tags, if desired, need to be comma separated, as in the [web-client](https://app.shlink.io/). If you don't choose a domain, i.e. by entering 1 or 2, it wil use 1.

When an argument is supplied to shlink.sh it will be treated as the long URL and input for this is skipped. Multiple arguments are treated as multiple long urls.

## TO-DO
Explain `shlinkinfo.sh` for retrieval of information.

## Requirements
[bash](https://www.gnu.org/software/bash/), [tr](http://www.gnu.org/software/coreutils/tr), [curl](https://curl.se/), [jq](https://stedolan.github.io/jq/)
