FROM debian:buster-slim

LABEL maintainer "NoEnv"
LABEL version "4.3.4"
LABEL description "Wazuh Agent"

RUN mkdir /var/log/remote_logs/

RUN apt-get update && apt-get install -y \
  procps curl apt-transport-https gnupg2 inotify-tools python-docker && \
  curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
  echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list && \
  apt-get update && \
  apt-get install -y wazuh-agent=4.3.4-1 && \
  rm -rf /var/lib/apt/lists/*

COPY ossec.conf /var/ossec/etc/ossec.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]