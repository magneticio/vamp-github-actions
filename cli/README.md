# GitHub Action for the Vamp CLI

The GitHub Action for [Vamp](https://vamp.io/) wraps the Vamp CLI to enable Vamp commands to be run. This can be used to create resources, deploy blueprints, migrate gateways, emit events, schedule workflows and other related tasks inside of an Action.

To log into Vamp, we recommend using the [Vamp Login](../login) Action or set the `VAMP_TOKEN` environment variable by using a secret.

## Usage

```
action "Deploy" {
  uses = "magneticio/vamp-github-actions/cli@master"
  args = "deploy myservice:1.0.0 myblueprint"
}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [Apache 2.0 License](LICENSE).