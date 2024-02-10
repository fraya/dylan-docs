# dylan-docs
Docker container to generate [Opendylan](https://opendylan.org) documentation.

It is based on the [Sphinx docker
image](https://github.com/sphinx-doc/sphinx-docker-images) and includes:

- [Dylan Sphinx extensions](https://github.com/dylan-lang/sphinx-extensions)

- [Furo theme](https://github.com/pradyunsg/furo), wich is the default
  them used in Opendylan's website.

Why? Opendylan packages' documentation expect that `sphinx-extension`
is installed in a specific directory and needs the 'furo' theme. It
makes the documentation generated in a GH Action difficult to make:

- Needs to install dylan-tool
- dylan-tool installs the dependencies of `sphinx-extensions`
- Download 'furo' theme.
- If the package don't 

## Usage

Download image

````
docker pull ghcr.io/fraya/dylan-docs
````

Generate documents from directory `./docs` where a Sphinx project
already exists.

````
docker run --rm -v ./docs:/docs --user "$(id -u):$(id -g)" ghrc.io/fraya/dylan-docs make html
````

## Build the image

To build the image, for instance with version `0.2.0` of `sphinx-extensions`:

````
docker build -t docker-docs:0.2.0 -t docker-docs:latest --build-arg VERSION=0.2.0 .
````

## Github Packages

This package is generated in the GH Action for the current version of
Sphinx extensions and uploaded to `ghcr.io/fraya/dylan-docs`.