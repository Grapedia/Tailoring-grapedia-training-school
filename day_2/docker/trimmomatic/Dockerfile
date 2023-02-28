FROM ubuntu:22.04

RUN apt-get -y update && \                                                                                           
    apt-get install -y --no-install-recommends \                                                                     
    build-essential \                                                                                                
    openssl libssl-dev \                                                                                             
    libpq-dev \
    ncbi-blast+ \
    unzip \
    wget \
    default-jre \
    && apt-get clean \                                                                                               
    && rm -rf /var/lib/apt/lists/*
                                                                                                                     
WORKDIR /app

RUN wget https://github.com/usadellab/Trimmomatic/files/5854859/Trimmomatic-0.39.zip && \
    unzip Trimmomatic-0.39.zip

CMD ["sleep", "infinity"]
