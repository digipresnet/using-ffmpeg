# Start from a base image with ffmpeg in it:
FROM jrottenberg/ffmpeg:4.1-ubuntu

# Install Python:
RUN apt-get update && apt-get install -y python3 python3-pip

# install the notebook package
RUN pip3 install --no-cache --upgrade pip && \
    pip3 install --no-cache notebook bash_kernel

# Setup bash kernel
RUN python3 -m bash_kernel.install

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

# Drop the parent image setup for entrypoint:
ENTRYPOINT []

CMD ["jupyter", "notebook"]
