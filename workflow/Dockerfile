FROM vlesierse/vamp-cli-ee

LABEL name="Vamp Workflow Action"
LABEL version="1.0.0"
LABEL repository="https://github.com/magneticio/vamp-github-actions"
LABEL homepage="https://vamp.io"

LABEL maintainer="Vamp <info@vamp.io>"
LABEL com.github.actions.name="GitHub Action for Vamp Workflow"
LABEL com.github.actions.description="This action creates a workflow using Vamp."
LABEL com.github.actions.icon="activity"
LABEL com.github.actions.color="blue"
COPY LICENSE README.md /

RUN npm install -g vamp-cli-ee

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
