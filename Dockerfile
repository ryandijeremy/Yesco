FROM python:3.9-slim
WORKDIR /
RUN apt update && apt -y install curl wget 
 && git clone https://github.com/akasakaid/onchenbot.git \
 && cd chain \
 && pip install -r requirements.txt \
  
# Copies the trainer code to the docker image.
COPY trainer /trainer
# Sets up the entry point to invoke the trainer.
ENTRYPOINT ["python", "-m", "trainer.task"]
