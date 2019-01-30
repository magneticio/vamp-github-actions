FROM magneticio/vamp-cli-ee

LABEL name="Vamp Login Action"
LABEL version="1.0.0"
LABEL repository="http://github.com/magneticio/vamp-github-actions"
LABEL homepage="https://vamp.io"

LABEL maintainer="Vamp <info@vamp.io>"
LABEL com.github.actions.name="GitHub Action for Vamp"
LABEL com.github.actions.description="This is an Action to log into Vamp."
LABEL com.github.actions.icon="log-in"
LABEL com.github.actions.color="blue"
COPY LICENSE README.md /

ENTRYPOINT vamp login -u $VAMP_USERNAME -p $VAMP_PASSWORD
