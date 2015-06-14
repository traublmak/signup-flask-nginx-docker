# Copyright 2014 Josh 'blacktop' Maine
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM nginx

RUN apt-get update
RUN apt-get install -y --no-install-recommends python-software-properties python-setuptools build-essential python-dev python git 
RUN easy_install pip
RUN pip install uwsgi
RUN pip install flask 

#ensure nginx starts automatically
RUN update-rc.d nginx enable

# install our code
ADD . /home/docker/code/

# Configure Nginx
RUN ln -s /home/docker/code/nginx-app.conf /etc/nginx/conf.d/

# run pip install
RUN pip install -r /home/docker/code/requirements.txt

# Start uWSGI daemon
EXPOSE 80 
#CMD ["uwsgi", "-s", "/tmp/uwsgi.sock", "-w", "application:application", "--chown-socket=nginx:nginx"]
CMD ["/home/docker/code/start.sh"]

