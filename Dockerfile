FROM drydock/u16all:tip

ADD . /u16phpall

RUN /u16phpall/install.sh
