FROM openjdk:8-alpine as builder

RUN apk update && apk add git maven

ENV INVEST_OPENAPI_JAVA_SDK_TAG_VERSION="v0.5"

WORKDIR /tmp/_build_invest-openapi
RUN git clone https://github.com/TinkoffCreditSystems/invest-openapi-java-sdk.git .
RUN git checkout "tags/${INVEST_OPENAPI_JAVA_SDK_TAG_VERSION}" -b "${INVEST_OPENAPI_JAVA_SDK_TAG_VERSION}-build"
RUN mvn clean package -pl '!example'

WORKDIR /target
RUN cp -r /tmp/_build_invest-openapi/core/target/openapi-java-sdk-core-*.jar .
RUN cp -r /tmp/_build_invest-openapi/sdk-java8/target/openapi-java-sdk-java8-*.jar .
RUN rm -rf /tmp/_build_invest-openapi
