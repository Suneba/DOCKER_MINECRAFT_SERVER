FROM ubuntu

RUN apt update

RUN apt install openjdk-17-jre -y
RUN apt install wget -y
RUN apt install screen -y
RUN apt install git -y
RUN apt-get install openssh-client -y
RUN apt install curl -y
RUN apt-get install jq -y




#RUN mkdir /home/minecraft

RUN ls -lah && ls -lah && ls -lah && cd /home && mkdir mine2 && cd /home/mine2 && git init && git pull https://github.com/kirusnovar/mine2.git master && cd .. && chmod +x mine2

RUN cd /home/mine2 && chmod +x server.jar && chmod +x only_push.sh && chmod +x only_pull.sh && chmod +x server1_start.sh && chmod +x push_service.sh && chmod 600 id_rsa.txt && chmod +x ngrok_script.sh

#RUN cd /home/mine2 && ssh-keygen -t rsa -b 4096 -q -f "/home/mine2" -P "" -C "kirus@kirus.icu"
#RUN cd /home/mine2 && eval "$(ssh-agent -s)" && ssh-add id_rsa.txt


RUN mkdir /home/ngrok && cd /home/ngrok && wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && tar zxvf ngrok-v3-stable-linux-amd64.tgz && ./ngrok config add-authtoken 293mQnrTLlgFuIQpm1yx73m4Fd8_26eCKetfQscyBcHFasC4n

EXPOSE 25565
EXPOSE 4040
EXPOSE 8080
EXPOSE 80

#::ffff:20.207.73.82
#20.207.73.82

CMD cd /home/mine2&& git pull https://github.com/kirusnovar/mine2.git master && mkdir /root/.ssh && ssh-keygen -t rsa -b 4096 -q -f "/root/.ssh/fake_key" -P "" -C "kirus@kirus.icu" && ssh-keyscan -H github.com >> /root/.ssh/known_hosts && eval "$(ssh-agent -s)" &&ssh-add id_rsa.txt  && cd /home/mine2 && echo starting_screen && screen -dmS minecraft ./server1_start.sh   && cd /home/mine2 && screen -dmS push_service ./push_service.sh && cd /home/mine2 && screen -dmS ngrok ./ngrok_script.sh && cd /home/ngrok && watch 'cat ngrok.log'