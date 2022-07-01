# mail-generator
> **WARNING**: this project is only for testing purposes

## Introduction
The goal of the project is to provide an automate way to send a bunch of `*.eml` files and report the results.


## How to use
1. Execute the following:
```
docker run \
    -v </path/to/mail>:/home/user/mail_examples/your_package:ro \
    -it drmatthew/mail-generator:latest \
    /home/user/mail_examples/ <mail_to> <mail_server>
```

where:
- `</path/to/mail>` -- is a host file system path to a folder with `*.eml` files.
- `<mail_to>` -- e-mail address like your@mail.box.
- `<mail_server>` -- IP address of SMTP server where to send e-mails.


## Example usage

That's how it looks like:
```
matvey@matvey-pc:~$ docker run -it drmatthew/mail-generator:latest \
> /home/user/mail_examples/ user@mail.org 172.17.32.3 

================ Overview ================
-> mail_directory: /home/user/mail_examples
-> mail_directory (packages): 1
-> mail_to: user@mail.org
-> mail_from: *@antispam.test.suite
-> mail_server: 172.17.32.3
==========================================

Do you want to start? [Confirm]
=============== PACKAGE #1 ===============
-> package_name: test_mail_package
-> mail sent/total: 3/3   (100.0%)
-> mail rejected/total: 1/3   (33.3%)
```

## Why?

It's quite useful for testing AntiSpam solutions.
If you're looking for spam examples, see [here](http://untroubled.org/spam/).

## License
MIT