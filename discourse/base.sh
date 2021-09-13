set -eux;

mkdir -p /usr/share/man/man1;

apt-get clean && apt-get update;

apt-get install -y locales locales-all;
locale-gen en_US

apt-get install -y --no-install-recommends \
        acl \
        advancecomp \
        anacron \
        autoconf \
        bison \
        brotli \
        bzip2 \
        ca-certificates \
        cmake \
        curl \
        dirmngr \
        dpkg-dev \
        file \
        g++ \
        gawk \
        gcc \
        ghostscript \
        gifsicle \
        git \
        gnupg \
        gzip \
        hostname \
        imagemagick \
        jhead \
        jpegoptim \
        less  \
        libatomic1 \
        libbsd0 \
        libbz2-1.0 \
        libbz2-dev \
        libc6 \
        libcom-err2 \
        libcurl4 \
        libedit2 \
        libffi-dev \
        libffi6 \
        libgcc1 \
        libgcrypt20 \
        libgdbm-compat-dev \
        libgdbm-dev \
        libglib2.0-dev \
        libgmp-dev \
        libgmp10 \
        libgnutls30 \
        libgpg-error0 \
        libgssapi-krb5-2 \
        libhogweed4 \
        libicu63 \
        libidn2-0 \
        libjpeg-turbo-progs \
        libk5crypto3 \
        libkeyutils1 \
        libkrb5-3 \
        libkrb5support0 \
        libldap-2.4-2 \
        liblzma5 \
        libncurses-dev \
        libncurses6 \
        libncursesw6 \
        libnettle6 \
        libnghttp2-14 \
        libp11-kit0 \
        libpq-dev \
        libpq5 \
        libpsl5 \
        libreadline-dev \
        libreadline-dev \
        libreadline7 \
        librtmp1 \
        libsasl2-2 \
        libsqlite3-0 \
        libssh2-1 \
        libssl-dev \
        libssl-dev \
        libssl1.1 \
        libstdc++6 \
        libtasn1-6 \
        libtcmalloc-minimal4 \
        libtinfo6 \
        libunistring2 \
        libunwind-dev \
        libuuid1 \
        libxml2 \
        libxml2-dev \
        libxml2-dev \
        libxml2-dev \
        libxslt-dev \
        libxslt1-dev \
        libxslt1.1 \
        libyaml-dev \
        make \
        optipng \
        parallel \
        pngcrush \
        pngcrush \
        pngquant \
        pngquant \
        procps \
        psmisc \
        rsync \
        ruby \
        sqlite3 \
        tar \
        vim \
        wget \
        wget \
        wget \
        whois \
        xz-utils \
        zlib1g \
        zlib1g-dev \
;


curl --silent --location https://deb.nodesource.com/setup_16.x | sh -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list


apt install -y nodejs;

npm install -g yarn && npm install -g terser && npm install -g uglify-js

apt -y install advancecomp jhead jpegoptim libjpeg-turbo-progs optipng

mkdir /jemalloc-stable && cd /jemalloc-stable &&\
      wget https://github.com/jemalloc/jemalloc/releases/download/3.6.0/jemalloc-3.6.0.tar.bz2 &&\
      tar -xjf jemalloc-3.6.0.tar.bz2 && cd jemalloc-3.6.0 && ./configure --prefix=/usr && make && make install &&\
      cd / && rm -rf /jemalloc-stable

mkdir /jemalloc-new && cd /jemalloc-new &&\
      wget https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2 &&\
      tar -xjf jemalloc-5.2.1.tar.bz2 && cd jemalloc-5.2.1 && ./configure --prefix=/usr --with-install-suffix=5.2.1 && make build_lib && make install_lib &&\
      cd / && rm -rf /jemalloc-new

echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
    mkdir /src && cd /src && git clone https://github.com/sstephenson/ruby-build.git &&\
    cd /src/ruby-build && ./install.sh &&\
    cd / && rm -rf /src/ruby-build && (ruby-build 2.7.4 /usr/local)

gem update --system


apt-get clean; \
rm -rf /var/lib/apt/lists/*; \

# apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; 
