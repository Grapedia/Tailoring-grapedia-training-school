FROM ubuntu:18.04

RUN apt-get -y update && \                                                                                           
    apt-get install -y --no-install-recommends \  
    python-setuptools \ 
    build-essential \
    python-dev \
    git \
    openssl libssl-dev \                                                                                             
    unzip \
    wget \
    python \
    python-pip \
    && apt-get clean \                                                                                               
    && rm -rf /var/lib/apt/lists/*
                                                                                                                     
WORKDIR /app

RUN pip install biopython==1.76 six

RUN git clone https://github.com/gao-lab/CPC2_standalone.git && \
    cd CPC2_standalone/ && \
    export CPC_HOME="$PWD" && \
    cd libs/libsvm && \
    gzip -dc libsvm-3.18.tar.gz | tar xf - && \
    cd libsvm-3.18 && \
    make clean && make

CMD ["sleep", "infinity"]
