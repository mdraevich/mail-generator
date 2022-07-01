FROM ubuntu:20.04

RUN apt-get update -y && \
    apt-get install swaks -y && \
    apt-get install bc -y

RUN useradd --create-home --no-log-init user

USER user
WORKDIR /home/user

COPY --chown=user . .

ENTRYPOINT ["./mail_tools/send_mail.bash"]