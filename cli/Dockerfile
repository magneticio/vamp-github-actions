FROM magneticio/vamp-cli-ee

LABEL name="vamp"
LABEL version="1.0.0"
LABEL repository="http://github.com/magneticio/vamp-github-actions"
LABEL homepage="https://vamp.io"

LABEL maintainer="Vamp <info@vamp.io>"
LABEL com.github.actions.name="GitHub Action for Vamp"
LABEL com.github.actions.description="Wraps the Vamp cli to enable Vamp commands."
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="blue"
COPY LICENSE README.md /

RUN npm install -g vamp-cli-ee

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]