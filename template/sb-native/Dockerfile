FROM maven:3.6.3-jdk-11 as builder


ENV APP_HOME=/root/sb-native/

RUN mkdir -p $APP_HOME/function

WORKDIR $APP_HOME

COPY ./ .


RUN addgroup --system app \
    && adduser --system --ingroup app app

RUN cd function \
    && mvn clean install \
    && cd ../ \
    && mvn clean install -DskipTests

#RUN apk --no-cache add curl \
#    && echo "Pulling watchdog binary from Github." \
#    && curl -sSLf https://github.com/openfaas-incubator/of-watchdog/releases/download/0.7.6/of-watchdog > /usr/bin/fwatchdog \
#    && chmod +x /usr/bin/fwatchdog \
#    && apk del curl --no-cache

FROM openfaas/of-watchdog:0.8.2 as watchdog
FROM openjdk:11-jre-slim as ship
RUN apt-get update -qqy \
  && apt-get install -qqy \
   --no-install-recommends \
   unzip
RUN addgroup --system app \
    && adduser --system --ingroup app app

COPY --from=watchdog  /fwatchdog .
RUN chmod +x /fwatchdog


#RUN apk --no-cache add ca-certificates

COPY --from=builder /root/sb-native/target/*.jar app.jar

#FROM openjdk

ENV fprocess="java -jar app.jar"
ENV mode="http"
ENV upstream_url="http://127.0.0.1:8081"

EXPOSE 8080 8081 8888

CMD ["./fwatchdog"]