FROM ubuntu.azurecr.io/ubuntu:noble
ARG TARGETARCH
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y wget git libicu-dev libnuma1

RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh && \
    chmod +x dotnet-install.sh && \
    ./dotnet-install.sh --channel 9.0 && \
    export DOTNER_ROOT=~/.dotnet && \
    export PATH=$PATH:~/.dotnet

ENV DOTNET_ROOT=/root/.dotnet
ENV PATH=$PATH:/root/.dotnet

RUN git clone --depth 1 https://github.com/liveans/QuicSimpleTest.git && \
    cd QuicSimpleTest && \
    dotnet build -c Release

WORKDIR /QuicSimpleTest

COPY msquic/artifacts/dist/libmsquic_*.deb /

RUN dpkg -i /libmsquic_*.deb

CMD ["dotnet", "run"]