FROM ubuntu:15.04
MAINTAINER Bradley Bossard <bradleybossard@gmail.com>

# Build the image
# docker build --rm -t docker-gnuspeech .

# Fire up an instance with a bash shell
# docker run --rm -i -t docker-gnuspeech

RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:george-edison55/cmake-3.x

RUN apt-get update

RUN apt-get install -y wget \
                       cmake \
                       software-properties-common \
                       build-essential

WORKDIR /root
RUN wget https://ftp.gnu.org/gnu/gnuspeech/gnuspeechsa-0.1.5.tar.gz

RUN tar -xvf gnuspeechsa-0.1.5.tar.gz
WORKDIR /root/gnuspeechsa-0.1.5

ENV pkg_dir /root/gnuspeechsa-0.1.5

RUN mkdir build

RUN cmake -D CMAKE_BUILD_TYPE=Release $pkg_dir
RUN make
RUN make install
RUN ldconfig

RUN mkdir /gnuspeech
RUN cp -R ./data /gnuspeech

RUN touch trm_param_file.txt; gnuspeech_sa -c /gnuspeech/data/en/ -p trm_param_file.txt -o output_file.wav "your text goes here"
