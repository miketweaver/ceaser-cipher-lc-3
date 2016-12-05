## Prerequisites

- gcc
- git

More info can be found in the lc3tools readme:
[https://github.com/haplesshero13/lc3tools](https://github.com/haplesshero13/lc3tools)

## Install lc3tools

    cd ~
    git clone https://github.com/haplesshero13/lc3tools
    cd lc3tools/
    ./configure
    make

## Download Ceaser Cipher lc-3

    cd ~
    git clone https://github.com/miketweaver/ceaser-cipher-lc-3

## Compile and run the caser.asm file.

    cd ceaser-cipher-lc-3/
    rm ceaser.obj ; ~/lc3tools/lc3as ceaser.asm && ~/lc3tools/lc3sim ceaser.obj

