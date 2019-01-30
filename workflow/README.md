# GitHub Action for Vamp Login

The GitHub Action for [Vamp](https://vamp.io/) Workflow wraps the Vamp CLI, allowing for Actions to create a Vamp Workflow.

> Currently only `daemon` schedules are supported.

## Usage

The following arguments are to be proved:

* `breed` - [**Required**] this is the breed containing the workflow code
* `name` - [**Optional**] this is the name of the workflow. If not provided a name will be generated based on the repository name, branch and short commit SHA

There is one required Secrets to be set:

* `VAMP_TOKEN` - this is the token used to log in to Vamp.

As alternative you can run the Vamp Login action prior to this action. This removes the need to set the `VAMP_TOKEN` secret.

Also the `VAMP_HOST` environment variable needs to be set using either a Secret or within the action.

An example of a workflow in Vamp would look like this:

```
action "Vamp Workflow" {
  uses = "magneticio/vamp-github-actions/workflow@master"
  secrets = ["VAMP_HOST", "VAMP_TOKEN"]
  args = ["canary", "app-canary"]
}
```

By default all `GITHUB_` prefixed environment variables are passed to Vamp. You can specify your own environment variables by prefix them with `WF_`. 

An example of a workflow with environment variables in Vamp would look like this:

```
action "Vamp Workflow" {
  uses = "magneticio/vamp-github-actions/workflow@master"
  secrets = ["VAMP_HOST", "VAMP_TOKEN"]
  args = ["canary", "app-canary"]
  env = {
      WF_GATEWAY = "app"
  }
}
```

When you specify a name for your workflow, it is also possible to use placeholder values.

* `%SHA%` - this is the full Git commit SHA
* `%SHA_SHORT%` - this is the short Git commit SHA. First 7 characters
* `%SHA_SHORT%` - this is the short Git commit SHA. First 7 characters
* `%REF_TYPE%` - this is the second part of a Git reference `refs/branch/master` will be `branch`
* `%REF_BRANCH%` - if the reference type is `branch` this value will be set to the branch name
* `%REF_TAG%` - if the reference type is `tag` this value will be set to the tag name

An example of a workflow with placeholder names in Vamp would look like this:

```
action "Vamp Workflow" {
  uses = "magneticio/vamp-github-actions/workflow@master"
  secrets = ["VAMP_HOST", "VAMP_TOKEN"]
  args = ["canary", "app-%REF_BRANCH%-%SHA_SHORT%"]
}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [Apache 2.0 License](LICENSE).