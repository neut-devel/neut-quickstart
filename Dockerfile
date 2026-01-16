FROM picker24/neut_580:alma9 

RUN dnf install -y python3-markdown lynx

RUN mkdir -p /opt/utils
ADD utils/halp \
    utils/neut-quickstart \
  /opt/utils

RUN chmod +x /opt/utils/*
ENV PATH=/opt/utils:${PATH} \
    OMP_NUM_THREADS=1