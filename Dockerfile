FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qqy
RUN apt-get install vlc sudo -qqy

RUN mkdir -p /opt/vlc-media

COPY ./media/* /opt/vlc-media/

RUN useradd vlcuser -M -d /opt/vlc-media -r -U

RUN echo -e "\nauth  [success=ignore default=1] pam_succeed_if.so user = vlcuser \nauth  sufficient                 pam_succeed_if.so use_uid user ingroup sudo \n" >> /etc/pam.d/su

EXPOSE 8080

EXPOSE 8554

RUN chown vlcuser:vlcuser -R /opt/vlc-media

ENTRYPOINT ["/use/bin/sudo","su","-","vlcuser",...]
