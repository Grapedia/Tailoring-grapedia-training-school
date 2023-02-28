FROM ubuntu:22.04

RUN apt-get -y update && \                                                                                           
    apt-get install -y --no-install-recommends \                                                                     
    build-essential \                                                                                                
    openssl libssl-dev \                                                                                             
    libpq-dev \
    ncbi-blast+ \
    && apt-get clean \                                                                                               
    && rm -rf /var/lib/apt/lists/*
                                                                                                                     
WORKDIR /app

CMD ["sleep", "infinity"]
