FROM nfcore/base:1.9
LABEL authors="Sangram Keshari Sahu" \
      description="Docker image containing all software requirements for the nf-core/gwasgsa pipeline"

# Install the conda environment
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /opt/conda/envs/nf-core-gwasgsa-1.0dev/bin:$PATH

# Dump the details of the installed packages to a file for posterity
RUN conda env export --name nf-core-gwasgsa-1.0dev > nf-core-gwasgsa-1.0dev.yml

# Install MAGMA
RUN apt-get update \
    && apt-get install wget zip unzip -y \
    && wget https://ctg.cncr.nl/software/MAGMA/prog/magma_v1.07bb.zip \
    && unzip magma_v1.07bb.zip \
    && cp magma /usr/bin/ \
    && wget https://github.com/shenwei356/csvtk/releases/download/v0.20.0/csvtk_linux_386.tar.gz \ 
    && tar -zxvf csvtk_linux_386.tar.gz \
    && cp csvtk /usr/bin/
