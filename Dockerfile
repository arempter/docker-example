FROM centos:8 AS stage-app

ENV SCALA_VERSION 2.13.3
ENV SBT_VERSION 1.3.13

# Install Java11
RUN yum install -y java-11-openjdk-devel

# Install Scala and SBT
RUN yum install -y http://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.rpm && \
    yum install -y https://dl.bintray.com/sbt/rpm/sbt-$SBT_VERSION.rpm && \
    yum install -y git

RUN git clone https://github.com/arempter/makisu-example.git -b update_app
RUN cd makisu-example && sbt universal:packageBin

FROM openjdk:11.0.8-jdk-slim
RUN apt-get install -y unzip
COPY --from=stage-app /makisu-example/target/universal/makisu_example-0.1.1.zip .
RUN unzip makisu_example-0.1.1.zip && chmod +x /makisu_example-0.1.1/bin/makisu_example
CMD ["./makisu_example-0.1.1/bin/makisu_example"]
