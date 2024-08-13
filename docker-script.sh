#! /bin/sh

sudo apt-get update
sudo apt-get install -y wget git libicu-dev

sudo apt-get install -y /artifacts/libmsquic_*.deb

sudo wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
sudo chmod +x dotnet-install.sh
sudo ./dotnet-install.sh --channel 9.0

export DOTNET_ROOT=/root/.dotnet
export PATH=$PATH:/root/.dotnet

sudo git clone --depth 1 https://github.com/liveans/QuicSimpleTest.git
cd QuicSimpleTest
sudo dotnet build -c Release
sudo dotnet run -c Release