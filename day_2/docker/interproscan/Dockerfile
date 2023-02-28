FROM ubuntu:22.04

RUN apt-get -y update && \                                                                                           
    apt-get install -y --no-install-recommends \                                                                     
    build-essential \                                                                                                
    libpcre3 \
    libpcre3-dev \
    libdw-dev \
    openssl libssl-dev \                                                                                             
    libpq-dev \
    unzip \
    wget \
    default-jre \
    python3 \
    && apt-get clean \                                                                                               
    && rm -rf /var/lib/apt/lists/*
                                                                                                                     
WORKDIR /app

RUN wget ftp://emboss.open-bio.org/pub/EMBOSS/old/6.5.0/EMBOSS-6.5.7.tar.gz && \
    tar -xvf EMBOSS-6.5.7.tar.gz && \
    cd EMBOSS-6.5.7/ && \
    ./configure --without-x && \
    make

COPY interproscan-5.60-92.0-64-bit.tar.gz /app

RUN tar -pxvzf interproscan-5.60-92.0-64-bit.tar.gz && \
    cd interproscan-5.60-92.0 && \
    python3 setup.py interproscan.properties

CMD ["sleep", "infinity"]
