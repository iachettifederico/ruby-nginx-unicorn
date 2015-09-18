# Ruby + Nginx, Unicorn Dockerfile

Ubuntu container running a Nginx/Unicorn configuration to run ruby projects.

## What's include

* unicorn, nginx, foreman


# Usage

* Create `Dockerfile` to your project and paste below code.

```
# Dockerfile
FROM fdx/ruby-nginx-unicorn
MAINTAINER Federico Iachetti

ADD . /app
RUN bundle install --without development test

#(required) nginx port number
EXPOSE 80
```

* Add `unicorn` gem(maybe uncomment `gem 'unicorn'` in `Gemfile`)

## Build and run docker

```
# build your dockerfile
$ docker build -t your/project .

# run container
$ docker run -d -p 80:80 -e SECRET_KEY_BASE=secretkey your/project
```
## Access bitbucket private repository

```
RUN mkdir /root/.ssh/
ADD id_rsa /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan -t rsa bitbucket.org >> /root/.ssh/known_hosts
```

Copy your `~/.ssh/id_rsa` to `id_rsa` for bitbucket connection. if you don't need to bitbucket connection, create blank `id_rsa`. don't forget add `id_rsa` to `.gitignore`



# TODO: Complete documentation
