FROM julia:1.6

# Extra dependencies for GLMakie.
RUN set -eux; \
      apt-get update; \
      apt-get install -y --no-install-recommends \
        freeglut3-dev \
        imagemagick \
        libgl1 \
        libxcursor-dev \
        libxext-dev \
        libxi-dev \
        libxinerama-dev \
        libxrandr-dev \
        mesa-utils \
        xauth \
        xorg-dev \
        xvfb \
      ; \
      rm -rf /var/lib/apt/lists/*

ENV DISPLAY=:0
ENV JULIA_NUM_THREADS=2

ENTRYPOINT ["/bin/sh", "-c", "/usr/bin/xvfb-run -s '-screen 0 1024x768x24' $@", ""]
CMD ["julia"]
