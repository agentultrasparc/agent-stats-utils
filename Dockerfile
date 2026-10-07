#
# docker build -t agentstats .
# docker run --rm -v ./data:/data -it agentstats
# docker run --rm -v ./data:/data -it --entrypoint /bin/sh agentstats
#

FROM python:3.14-alpine3.24 AS compile-image
RUN apk update

RUN python -m venv /app/venv
# Make sure we use the virtualenv:
ENV PATH="/app/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install -r requirements.txt

FROM python:3.14-alpine3.24 AS build-image
RUN addgroup -S -g 1000 agentstats && adduser -S agentstats -s /bin/sh -u 1000 -G agentstats
RUN mkdir /data && chown agentstats:agentstats /data && chmod 0700 /data

USER agentstats
COPY --from=compile-image /app/venv /app/venv
COPY --chmod=0555 agent_stats.py flagtool.py /app/
COPY --chmod=0444 mail.py slack.py Stat.py util.py /app/
COPY templates/ /app/templates

# Make sure we use the virtualenv:
ENV PATH="/app/venv/bin:/app:$PATH"

# Where to put secrets.py, optional extra_stats.py, and the sqlite database
ENV PYTHONPATH="/data"

ENTRYPOINT ["/app/agent_stats.py"]
