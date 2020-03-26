FROM 'ubuntu:18.04'

COPY ~/Downloads/pivotal-tc-server_4.0.11-RELEASE_all.deb /tmp
COPY openjdk-jdk-1.8.0_222-bionic.tar.gz /tmp
COPY pivotal-tc-runtime-9_9.0.31.A-RELEASE_all.deb /tmp

RUN dpkg -i /tmp/pivotal-tc-server_4.0.11-RELEASE_all.deb /tmp/pivotal-tc-runtime-9_9.0.31.A-RELEASE_all.deb
RUN mkdir -p /opt/java/openjdk-jdk-1.8.0_222 && \
    tar xzf /tmp/openjdk-jdk-1.8.0_222-bionic.tar.gz -C /opt/java/openjdk-jdk-1.8.0_222

ENV TCSERVER_HOME=/opt/pivotal/tcserver/standard
ENV TCSERVER_RUNTIMES_DIRECTORY=/opt/pivotal/tcserver/runtimes
ENV TCSERVER_INSTANCES_DIRECTORY=/var/opt/pivotal/tcserver/instances

ENV JAVA8_HOME=/opt/java/openjdk-jdk-1.8.0_222
ENV JAVA_HOME=$JAVA8_HOME
ENV PATH=$TCSERVER_HOME:$JAVA_HOME/bin:$PATH
ENV INSTANCE_NAME=instance

USER tcserver
CMD $TCSERVER_HOME/tcserver run $INSTANCE_NAME
