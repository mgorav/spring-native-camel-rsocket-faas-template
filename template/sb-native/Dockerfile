FROM openjdk:11-jdk-slim as builder


ENV APP_HOME=/root/sb-native/

RUN mkdir -p $APP_HOME/function

WORKDIR $APP_HOME

COPY ./ .

#RUN cd function \
#    && mvn clean install \
#    && cd ../ \
#    && mvn clean install spring-boot:build-image -DskipTests

#RUN apk --no-cache add curl \
#    && echo "Pulling watchdog binary from Github." \
#    && curl -sSLf https://github.com/openfaas-incubator/of-watchdog/releases/download/0.7.6/of-watchdog > /usr/bin/fwatchdog \
#    && chmod +x /usr/bin/fwatchdog \
#    && apk del curl --no-cache

FROM openfaas/of-watchdog:0.7.6 as watchdog
COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

FROM openjdk

#RUN apk --no-cache add ca-certificates

COPY --from=builder /root/sb-native/target/*.jar app.jar
COPY --from=builder /usr/bin/fwatchdog .

ENV fprocess="java -jar app.jar"
ENV mode="http"
ENV upstream_url="http://127.0.0.1:8081"

CMD ["./fwatchdog"]