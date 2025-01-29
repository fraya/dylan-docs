# dylan-docs
Docker container to generate [Opendylan](https://opendylan.org) documentation.

It is based on the [Sphinx docker
image](https://github.com/sphinx-doc/sphinx-docker-images) and includes:

- [Dylan Sphinx extensions](https://github.com/dylan-lang/sphinx-extensions)

- [Furo theme](https://github.com/pradyunsg/furo), which is the default
  them used in Opendylan's website.

- [Sphinx
  copybutton](https://sphinx-copybutton.readthedocs.io/en/latest/) to
  add a copy button in the right of the code blocks. See usage below.

- [Sphinx PlantUML](https://github.com/sphinx-contrib/plantuml) to
  create UML diagrams and other software development related formats
  (see [PlantUML in Wikipedia](https://en.wikipedia.org/wiki/PlantUML)).
  See usage below.

| :exclamation: Important |
|-------------------------|

This container requires that the path to `sphinxcontrib` in the file
`conf.py` is exactly:

    '../../_packages/sphinx-extensions/current/src/sphinxcontrib'

which is the standard path where `dylan-tool` install the dependency.

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

with `podman`

```
podman run --rm -v ./docs:/docs:z ghcr.io/fraya/dylan-docs make html
```

### Copy button

To use _copy button_ add in your `conf.py` configuration file the
`sphinx_copybutton` to your extension list, e.g.:

````python
extensions = [
  ...
  'sphinx_copybutton'
  ...
]
````

### PlantUML

Add `sphinxcontrib.plantuml` to your extension list in your `conf.py`:

```python
extensions = [
  'sphinxcontrib.plantuml',
]
```

And specify the plantuml command (included in the image) in your
`conf.py`:

```python
plantuml = '/usr/local/bin/plantuml'
```

### Creation of a document project

To create the structure of the documentation for a new project, we use
the interactive `sphinx-quickstart`.

First, create the documentation directory

````
mkdir docs; cd docs
````

Then we call the container in an interactive way:

````
podman run --rm -ti -v ./docs:/docs:z ghcr.io/fraya/dylan-docs sphinx-quickstart
````

## Build the image

To build the image, for instance with version `0.2.0` of `sphinx-extensions`:

````
docker build -t docker-docs:0.2.0 -t docker-docs:latest --build-arg SPHINX_EXTENSIONS_VERSION=0.2.0 .
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