# GitHub Action for Vamp Login

The GitHub Action for [Vamp](https://vamp.io/) Login wraps the Vamp CLI's `vamp login` command, allowing for Actions to log into Vamp.

Because `$HOME` is persisted across Actions, the `vamp login` command will save this information into `$HOME/.vamp`, allowing other Actions to push, pull or otherwise modify images.

## Usage

There are two required Secrets to be set:

* `VAMP_USERNAME` - this is the username used to log in to Vamp.
* `VAMP_PASSWORD` - this is the password used to log in to Vamp.

Also the `VAMP_HOST` environment variable needs to be set using either a Secret or within the action.

An example of logging into Vamp would look like this:

```
action "Vamp Login" {
  uses = "magneticio/vamp-github-actions/cli@master"
  secrets = ["VAMP_HOST", "VAMP_USERNAME", "VAMP_PASSWORD"]
}
```

Or if you don't want to specify `VAMP_HOST` as a Secret:

```
action "Vamp Login" {
  uses = "magneticio/vamp-github-actions/cli@master"
  secrets = ["VAMP_USERNAME", "VAMP_PASSWORD"]
  env = {
    VAMP_HOST = "https://vamp.example.com"
  }
}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [Apache 2.0 License](LICENSE).