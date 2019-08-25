FROM ubuntu as builder

USER root

RUN apt -y update && apt -y install net-tools netcat

#USER user
WORKDIR /trash


FROM builder as builder-test

#RUN touch ./test_file
RUN test -f ./test_file


FROM builder

EXPOSE 4040
EXPOSE 4050
EXPOSE 11223

ENTRYPOINT [ "netcat" ]

CMD [ "-l", "11223" ]

