FROM amazon/dynamodb-local
USER root
RUN yum -y install aws-cli
VOLUME /init-scripts
ADD init-scripts.sh /
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]