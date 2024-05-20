#
# Create an image with 'sphinx-extensions' in it to create
# Opendylan's documentation
#
# We install the extension in the same folder that 'dylan-tool' installs
# the package in local. 
#
# To build for instance with version 0.2.0:
#
#   docker build -t docker-docs:0.2.0 -t latest --build-arg VERSION=0.2.0 .
#

FROM sphinxdoc/sphinx

# sphinx-extensions version, i.e., 0.2.0
ARG VERSION

ADD requirements.txt /docs
RUN pip3 install -r requirements.txt

# File downloaded from sphinx-extensions project with extension .tgz
# If the file is a local .tgz it is uncompressed with ADD
ADD v${VERSION}.tar.gz /

# directory where the extension should be
ARG EXTENSION_HOME=/_packages/sphinx-extensions/current/src

# move extension to its home and clean
RUN mkdir -p ${EXTENSION_HOME} \
 && mv /sphinx-extensions-${VERSION}/sphinxcontrib ${EXTENSION_HOME} \
 && rm -rf /sphinx-extensions-${VERSION} 