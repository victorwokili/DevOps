FROM ubuntu

RUN apt update -y 

COPY terraform-install.sh /tmp/terraform-install.sh

RUN cd /tmp/ && sh terraform-install.sh

RUN apt full-upgrade -y && apt install python-pip -y && pip2 install flask

# RUN pip2 install flask

WORKDIR /opt

COPY app.py /opt/app.py

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080

LABEL project="jjtech"





