# Meshdown

This is a script to create a Docker image for downloading 3d meshes as `obj` files which can be imported into [MeshLab](http://www.meshlab.net) (or other 3d triangular mesh software). Some of the required packages don't currently support Windows, and Docker allows you to run Linux inside a container on a Windows machine.

# Installation

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop).

2. Download the files from this repository. The easiest way to do this is to run `git clone https://github.com/murthylab/Meshdown.git` from [Cmder](https://cmder.net). This will create a `Meshdown` directory inside your current working directory.

3. The default datasource is set in `datasource.txt`. If you want to use a different datasource, edit this file inside the `Meshdown` directory.

4. Some CloudVolume datasources require [credentials](https://github.com/seung-lab/cloud-volume#credentials) for access. If you want to use a datasource which requires credentials, you'll need to create a file with your key.

## Credentials

 Here are instructions that work for a Graphene datasource:

1. Go [here](https://fafbv2.dynamicannotationframework.com/auth/refresh_token) and if prompted, sign in with the Google account that has access to this datasource.

2. You'll see something like `"2fd4e1c67a2d28fced849ee1bb76e739"`. Copy this text.

3. In the directory of files you downloaded from this repository, create a text file called `chunkedgraph-secret.json` (inside the `Meshdown` directory) with this text:

> {"token": "..."}

(where `"..."` should be the text you copied in step 2).

When you build the docker image, this file will be copied into the image in the appropriate location.

## Building the image

Navigate to inside the `Meshdown` directory, and run

> docker build -t meshdown:v1 .

(Note the "." at the end.)

This will take a few minutes but only has to be done once. If you ever want to build a new image that uses a different datasource and/or credentials, you'll have to do this again but it won't take very long since it doesn't have to rebuild the full image.

# Using meshdown

1. Choose a directory where the mesh `obj` files should be downloaded. For this example I'll use `c:/path/to/my_downloads/`.

2. Get the list of mesh id's you want to download. For this example, I'll use `720575940611425556,720575940634015088`.

2. From a command line (e.g., Cmder), run

> docker run -v <download_path>:/meshes --rm meshdown:v1 python meshdown.py <mesh_list>

with `<download_path>` and `<mesh_list>` replaced with the appropriate text. For example, with `c:/path/to/my_downloads` as the download path and `720575940611425556,720575940634015088` as the mesh id's, this will be:

> docker run -v c:/path/to/my_downloads:/meshes --rm meshdown:v1 python meshdown.py \
> 720575940611425556,720575940634015088

If everything works, you'll end up with `c:/path/to/my_downloads/720575940611425556.obj` and `c:/path/to/my_downloads/720575940634015088.obj`.
