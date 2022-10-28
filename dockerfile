

FROM python:3.10

RUN apt-get update && \
    apt-get install -y && \
    python3 -m pip install --upgrade pip && \
    pip3 install daphne 

COPY . /opt/HNG-SERVER-TASK-API
WORKDIR /opt/HNG-SERVER-TASK
RUN pip3 install -r /opt/HNG-SERVER-TASK-API/requirements.txt
RUN pip3 install psycopg2
WORKDIR /opt/HNG-SERVER-TASK-API/task_site
RUN python3 manage.py collectstatic
EXPOSE 9180

CMD ["gunicorn", "-b", "0.0.0.0:9180", "task_site.asgi:app"]