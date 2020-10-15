# Use Java 8 slim JRE
FROM openjdk:8-jre-slim

# JMeter version
ARG JMETER_VERSION=5.3
#ARG JVM_ARGS

# Install few utilities
RUN apt-get clean && \
    apt-get update && \
    apt-get -qy install \
                wget \
                telnet \
                iputils-ping \
                curl \
                unzip

# Install JMeter

# # Copy zipped jmeter folder from Network Drive.
# RUN cd /opt 


# RUN unzip -q "*.zip"

RUN   mkdir /jmeter \
      && cd /jmeter/ 
    #   && wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
    #   && tar -xzf apache-jmeter-$JMETER_VERSION.tgz \
    #   && rm apache-jmeter-$JMETER_VERSION.tgz
# COPY apache-jmeter-5.3.tgz /jmeter
# RUN cd /jmeter/ \
#     && tar -xzf apache-jmeter-5.3.tgz \
#     && rm apache-jmeter-$JMETER_VERSION.tgz

COPY apache-jmeter-5.3.zip /jmeter
RUN cd /jmeter/ \
    && unzip -q "*.zip" \
    && rm apache-jmeter-$JMETER_VERSION.zip \
    && chmod 777 /jmeter/apache-jmeter-5.3//bin/*



# Set JMeter Home
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/

# Add JMeter to the Path
ENV PATH $JMETER_HOME/bin:$PATH

ENV JVM_ARGS="-Xms1024m -Xmx1024M"


# Ports to be exposed from the container for JMeter Master
EXPOSE 4444

#ENTRYPOINT ["sh", "-c"]
#CMD ["set JVM_ARGS='-Xms1024m -Xmx1024M'"]



















# FROM openjdk:8-jre-slim
# # JMeter Version
# ARG JMETER_VERSION="5.3"
# # Download and unpack the JMeter tar file

# RUN pwd

# # Install unzip
# RUN apt-get clean && \
#     apt-get update && \
#     apt-get -qy install \
#                 wget \
#                 telnet \
#                 iputils-ping \
#                 unzip

# # Copy zipped jmeter folder from Network Drive.
# RUN cd /opt 

# COPY apache-jmeter-5.3.zip ./
# RUN unzip -q "*.zip"
# RUN find . -name '*.zip' -delete

# # Create a symlink to the jmeter process in a normal bin directory
# RUN ln -s /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter /usr/local/bin

# # Set JMeter Home
# ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}/

# # Add JMeter to the Path
# ENV PATH $JMETER_HOME/bin:$PATH

# # Copying custom property file
# COPY sample-test.jmx /opt/apache-jmeter-${JMETER_VERSION}/bin/sample-test.jmx

# # Indicate the default command to run
# CMD hostname