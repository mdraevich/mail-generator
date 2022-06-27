FROM ubuntu:20.04

RUN apt-get update -y && \
    apt-get install swaks -y
RUN useradd --create-home --no-log-init user

USER user
WORKDIR /home/user

COPY . .
CMD ["bash"]