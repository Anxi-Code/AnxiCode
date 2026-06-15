# Java docker file

FROM eclipse-temurin:17-jdk-alpine

WORKDIR /sandbox

CMD ["sh", "-c", "javac Main.java && java Main"]