#! /bin/sh
cd /main

sudo apt-get update
sudo apt-get install -y wget git libicu-dev zlib1g-dev clang

sudo apt-get install -y ./artifacts/libmsquic_*.deb

cd ./artifacts/bin/linux/${1}_${2}_${3}
sudo chmod +x msquictest
sudo ./msquictest --gtest_filter=ParameterValidation.ValidateApi
cd ../../../..

sudo wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
sudo chmod +x dotnet-install.sh
sudo ./dotnet-install.sh --channel 9.0

export DOTNET_ROOT=/root/.dotnet
export PATH=$PATH:/root/.dotnet

cd QuicSimpleTest
sudo dotnet ./bin/$2/net9.0/linux-${1}/QuicHello.dll

# sudo git clone --depth 1 https://github.com/liveans/QuicSimpleTest.git
# cd QuicSimpleTest
# sudo dotnet build -c Release
# sudo dotnet run -c Release