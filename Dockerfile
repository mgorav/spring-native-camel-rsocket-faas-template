FROM 3.6.3-jdk-11 as builder

ENV APP_HOME=/root/springboot/

RUN mkdir -p $APP_HOME/function

WORKDIR $APP_HOME

COPY . .

RUN cd function \
    && mvn clean install \
    && cd ../ \
    && mvn clean install spring-boot:build-image -DskipTests

RUN apk --no-cache add curl \
    && echo "Pulling watchdog binary from Github." \
    && curl -sSLf https://github.com/openfaas-incubator/of-watchdog/releases/download/0.8.4/of-watchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog \
    && apk del curl --no-cache

FROM openjdk

RUN apk --no-cache add ca-certificates

COPY --from=builder /root/springboot/target/*.jar app.jar
COPY --from=builder /usr/bin/fwatchdog .

ENV fprocess="java -jar app.jar"
ENV mode="http"
ENV upstream_url="http://127.0.0.1:8081"

CMD ["./fwatchdog"]

