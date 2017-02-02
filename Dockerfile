FROM drydock/u16all:{{%TAG}}

ADD . /u16phpall

RUN /u16phpall/install.sh
