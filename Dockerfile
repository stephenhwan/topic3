FROM jenkins/jenkins:lts

USER root

# Expose Jenkins ports
EXPOSE 8080
EXPOSE 50000

# Set up Jenkins volume and Docker socket volume
VOLUME /var/jenkins_home
VOLUME /var/run/docker.sock

# Install Docker CLI
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh

# Set Docker CLI path
ENV PATH="/usr/bin/docker:${PATH}"
# Copy tini binary
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /sbin/tini
RUN chmod +x /sbin/tini
# Set entrypoint to start Jenkins
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]