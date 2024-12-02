#Use CentOS as the container OS
FROM ubuntu:24.04
#Copy our files to the container
COPY . ./app
#Install python and other programs required to run our app
RUN apt update && apt-get install -y software-properties-common && add-apt-repository ppa:deadsnakes/ppa && apt install -y python3.11 python3.11-venv which gcc
#Change the working directory to /app
WORKDIR /app
#Changing the default python version from 2 to 3. We do this by first renaming the old python version and linking python filename to python3.6.
#RUN mv /usr/bin/python /usr/bin/python_old
RUN python3.11 -m venv .venv
RUN cd /usr/bin && ln -s /app/.venv/bin/python python
#Install the required python packages listed in the requirements file
RUN .venv/bin/python -m pip install -r requirements.txt
#Run uwsgi with the configuration in the .ini file
CMD ["/app/.venv/bin/uwsgi","--ini","app.ini"]
#Expose port 90 of the container to the outside
EXPOSE 5000