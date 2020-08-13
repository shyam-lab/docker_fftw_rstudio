FROM rocker/rstudio:3.5.2

WORKDIR /build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y zlib1g-dev \
 && cd /build \
 && mkdir fftw3 \
 && cd fftw3 \
 && wget http://www.fftw.org/fftw-3.3.8.tar.gz \
 && tar -xzvf fftw-3.3.8.tar.gz \
 && cd fftw-3.3.8 \
 && ./configure --prefix=/build/fftw3 --enable-shared \
 && make && make install

RUN  mkdir /home/rstudio/data \
 && mkdir /home/rstudio/data1 \
 && mkdir /home/rstudio/data2 \
 && mkdir /home/rstudio/tutorial \
 && cd /home/rstudio/tutorial \
 && wget http://zzz.bwh.harvard.edu/dist/luna/tutorial.zip \
 && unzip tutorial.zip \
 && rm tutorial.zip \
 && chown -R rstudio /home/rstudio

RUN R -e "install.packages('plotrix', repos='http://cran.rstudio.com/')" \
 && R -e "install.packages('geosphere', repos='http://cran.rstudio.com/')"
