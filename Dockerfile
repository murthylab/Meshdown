FROM conda/miniconda3 as meshparty

RUN apt-get update && apt-get install -y gcc mayavi2

RUN conda install python=3.7 numpy
RUN conda install -c conda-forge pyembree pykdtree python-blosc
RUN pip install vtk==8.1.2 mayavi annotationframeworkclient meshparty

FROM meshparty

ADD *.json /root/.cloudvolume/secrets/
COPY datasource.txt datasource.txt
COPY meshdown.py meshdown.py
