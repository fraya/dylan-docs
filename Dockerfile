FROM docker.io/sphinxdoc/sphinx:8.1.3

ENV BUILD_DEPENDS \
    curl

ENV SPHINX_EXTENSIONS_VERSION 0.2.0
ENV SPHINX_EXTENSIONS v$SPHINX_EXTENSIONS_VERSION.tar.gz
ENV SPHINX_EXTENSIONS_DOWNLOAD_URL https://github.com/dylan-lang/sphinx-extensions/archive/refs/tags/$SPHINX_EXTENSIONS
ENV SPHINX_EXTENSIONS_HOME /_packages/sphinx-extensions/current/src

# Install packages
RUN apt-get update && \
    apt-get install -y $BUILD_DEPENDS && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download, decompress and install Sphinx extensions

RUN curl -fsSL "$SPHINX_EXTENSIONS_DOWNLOAD_URL" -o $SPHINX_EXTENSIONS && \
    tar xfz $SPHINX_EXTENSIONS && \
    mkdir -p ${SPHINX_EXTENSIONS_HOME} && \
    mv sphinx-extensions-${SPHINX_EXTENSIONS_VERSION}/sphinxcontrib ${SPHINX_EXTENSIONS_HOME} && \
    rm -rf /sphinx-extensions-${SPHINX_EXTENSIONS_VERSION}

# Install Sphinx modules

ADD requirements.txt /docs
RUN pip3 install -r requirements.txt
