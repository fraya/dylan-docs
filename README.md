# dylan-docs
Docker container to generate [Opendylan](https://opendylan.org) documentation.

It is based on the [Sphinx docker
image](https://github.com/sphinx-doc/sphinx-docker-images) and includes:

- [Dylan Sphinx extensions](https://github.com/dylan-lang/sphinx-extensions)

- [Furo theme](https://github.com/pradyunsg/furo), wich is the default
  them used in Opendylan's website.

| :exclamation: Important |
|-------------------------|

This container requires that the path to `sphinxcontrib` in the file
`conf.py` is exactly:

    '../../_packages/sphinx-extensions/current/src/sphinxcontrib'

wich is the standard path where `dylan-tool` install the dependency.

## Usage

Download image

````
docker pull ghcr.io/fraya/dylan-docs
````

Generate documents from directory `./docs` where a Sphinx project
already exists.

````
docker run --rm -v ./docs:/docs --user "$(id -u):$(id -g)" ghcr.io/fraya/dylan-docs make html
````

## Build the image

To build the image, for instance with version `0.2.0` of `sphinx-extensions`:

````
docker build -t docker-docs:0.2.0 -t docker-docs:latest --build-arg VERSION=0.2.0 .
````

## Github Packages

This package is generated in the GH Action for the current version of
Sphinx extensions and uploaded to `ghcr.io/fraya/dylan-docs`.

## Why?

The process of creating the documentation in GH Actions is complex and
requires:

- Install Sphinx doc

- Install dylan-tool which requires download Opendylan.

- Install the dependency of `sphinx-extensions`

- Sometimes make links between the directories to adjust the path to
  `sphinx-extensions`.

- Install 'furo' theme.

In between this process will be easier once `dylan-tool` is used in
all projects, this container makes the building of documentation
faster and easier.