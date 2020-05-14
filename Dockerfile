FROM debian:buster

# Configuration variables
ENV HUGO_VERSION 0.70.0
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit.deb
ENV CONTAINER_USER static
ENV HOME_DIR "/home/${CONTAINER_USER}"
ENV TERRAFORM_VERSION 0.12.24
ENV TERRAFORM_BINARY terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ENV AWS_CLI_BINARY awscli-exe-linux-x86_64.zip

# Install system tools
RUN apt-get -qq update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends ca-certificates curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Download and install hugo
RUN curl -sL -o /tmp/hugo.deb \
    https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb

# Download and install terraform
RUN curl -sL -o /tmp/terraform.zip \
    https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_BINARY} && \
    unzip /tmp/terraform.zip -d /tmp && \
    mv /tmp/terraform /usr/local/bin && \
    terraform -install-autocomplete && \
    rm /tmp/terraform.zip

# Download and install AWS CLI
RUN curl -sL -o /tmp/awscli.zip https://awscli.amazonaws.com/${AWS_CLI_BINARY} && \
    unzip /tmp/awscli.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/awscli.zip /tmp/aws

# Add container user
RUN addgroup ${CONTAINER_USER} && adduser --home ${HOME_DIR} --ingroup ${CONTAINER_USER} --disabled-password --gecos ${CONTAINER_USER} ${CONTAINER_USER}

# Expose default hugo port
EXPOSE 1313

# Start in shell
USER ${CONTAINER_USER}
WORKDIR ${HOME_DIR}
CMD /bin/bash