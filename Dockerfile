#
# docker build -t agentstats .
# docker run --rm -v ./data:/data -it agentstats
# docker run --rm -v ./data:/data -it --entrypoint /bin/sh agentstats
#

ARG UID=1000
ARG GID=1000
ARG PYTHON_VER=3.14
ARG ALPINE_VER=3.24

###########
FROM python:${PYTHON_VER}-alpine${ALPINE_VER} AS compile-image

ARG UID GID # Inherit from global scope

USER ${UID}:${GID}
WORKDIR /app
RUN python -m venv ./venv

# Make sure we use the virtualenv:
ENV PATH="/app/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

###########
FROM python:${PYTHON_VER}-alpine${ALPINE_VER} AS build-image

ARG UID GID # Inherit from global scope

RUN addgroup -S -g ${GID} agentstats
RUN adduser -S agentstats -s /bin/sh -h /data -u ${UID} -G agentstats
USER agentstats:agentstats
VOLUME /data

COPY --from=compile-image /app/venv /app/venv

WORKDIR /app
COPY --chmod=0555 agent_stats.py flagtool.py .
COPY --chmod=0444 mail.py slack.py Stat.py util.py .
COPY templates/ ./templates

# Make sure we use the virtualenv:
ENV PATH="/app/venv/bin:/app:$PATH"

# Where to put secrets.py, optional extra_stats.py, and the sqlite database
ENV PYTHONPATH="/data"

VOLUME /data
WORKDIR /data
ENTRYPOINT ["/app/agent_stats.py"]
