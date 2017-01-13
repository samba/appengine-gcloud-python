# Google AppEngine Python Environment

Goals:

- Simplify integration testing against the Google Cloud SDK
- Support deployment operations for Python applications in Google
AppEngine

Until recently, [mgood's container][1] proved sufficient, but is now outdated
for my purposes.

## Encrypted Environment Variables

This container now incldues a utility `env_secure.sh`, which supports
extraction of credentials and other private data from environment
variables that are encrypted. It's assumed that the content of the
environment variables is also Base-64 encoded.

Common use-cases for this would include continuous integration and 
deployment environments, such as GitLab CI.

While not the pinacle of security, it presents some improvement.
It does store files, when needed, in `${HOME}/.secure/stash`.

The encryption used is AES-256 via OpenSSL.

Usage:

```shell

# Read the content directly, printing the string.
echo "${ENV_VAR}" | env_secure.sh decode "${PASSWORD}"

# Stash the content to a file, printing the resulting filename.
filename=`echo "${ENV_VAR}" | env_secure.sh file "${PASSWORD}"`
cat $filename # to read the sensitive data

# To clean the temporary files:
env_secure.sh clean


# To generate the encoded form:
echo "${sensitive_data}" | env_secure.sh encode "${PASSWORD}"

```



[1]: https://hub.docker.com/r/mgood/appengine-python/
[2]: https://github.com/blacklabelops/gcloud
[3]: https://bitbucket.org/cwt/alpine-gcloud/src/master/Dockerfile?at=master&fileviewer=file-view-default
[4]: https://hub.docker.com/r/joakimbeng/gcloud/~/dockerfile/
