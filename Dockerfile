FROM ubuntu:jammy
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER activer
RUN echo activer
CMD echo activer
COPY . .


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo curl apt-utils libqt5gui5 python3-psutil wget python3 python3-pip p7zip-full git build-essential


RUN wget --no-check-certificate "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/master/Goi5.1.bin.7z" -O Goi5.1.bin.7z
RUN 7z e Goi5.1.bin.7z
RUN rm Goi5.1.bin.7z
RUN wget --no-check-certificate "https://gitlab.com/OIVAS7572/Cerebellum3merge.bin/-/raw/master/Cerebellum3Merge.bin.7z" -O Cerebellum3Merge.bin.7z
Run 7z e Cerebellum3Merge.bin.7z
RUN rm Cerebellum3Merge.bin.7z
#RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/3ec6e1d2450183ed4975cf569b5a1286cb9d8369/linux64/stockfish_22021301_x64.zip" -O chess-engine.zip
RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/9f6bcb38c032a18c8b1aec318d5c7255827f9c7b/linux64ssse/stockfish_22040110_x64_ssse.zip" -O chess-engine.zip
RUN 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x chess-engine
RUN chmod +x ./engines/fairy-sf
RUN chmod +x ./engines/fsf_linux 
RUN chmod +x ./engines/fsf
RUN chmod +x ./engines/StarTwinkLight_Standard
RUN chmod +x ./engines/StarTwinkLight_variant

# Engine name is here ^^^^^^
