FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qqy
RUN apt-get install vlc sudo -qqy

RUN mkdir -p /opt/vlc-media

# COPY ./media/* /opt/vlc-media/

RUN useradd vlcuser -M -d /opt/vlc-media -r -U

RUN echo -e "\nauth  [success=ignore default=1] pam_succeed_if.so user = vlcuser \nauth  sufficient                 pam_succeed_if.so use_uid user ingroup sudo \n" >> /etc/pam.d/su

EXPOSE 8080

RUN chown vlcuser:vlcuser -R /opt/vlc-media

ENTRYPOINT /usr/bin/sudo su - vlcuser -c "cvlc -I http --http-host 0.0.0.0 --http-port 8080 --http-src=/opt/vlc-media --http-password senha123 -vvv --file-logging --logmode=text --logfile=/opt/vlc-media/vlclog.txt"