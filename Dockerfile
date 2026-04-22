FROM openjdk:11.0-jdk-slim

RUN mkdir /javavulny /app
COPY . /javavulny/
RUN sed -i 's/localhost\:5432/db\:5432/' /javavulny/src/main/resources/application-postgresql.properties

RUN cd /javavulny \
&& ./gradlew --no-daemon build \
&& cp build/libs/java-spring-vuly-0.1.0.jar /app/ \
&& rm -Rf build/ \
&& cd / \
&& rm -Rf /javavulny /root/.gradle/

WORKDIR /app

ENV PWD=/app
RUN useradd -U -u 1000 appuser && chown -R 1000:1000 /app
USER 1000
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/java-spring-vuly-0.1.0.jar"]
