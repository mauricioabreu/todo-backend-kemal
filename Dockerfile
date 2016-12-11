FROM ubuntu:16.04

RUN apt-get update && \
apt-get install -y apt-transport-https curl build-essential pkg-config libssl-dev llvm-3.6 libedit-dev libgmp-dev libxml2-dev libyaml-dev libreadline-dev git-core && \
apt-key adv --keyserver keys.gnupg.net --recv-keys "09617FD37CC06B54" && \
echo "deb https://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list && \
apt-get update && \
curl https://dist.crystal-lang.org/apt/setup.sh | bash && \
apt-get update && \
apt-get install -y crystal git

COPY . /code
WORKDIR /code

RUN crystal deps

RUN crystal build --release src/todo_app.cr

RUN crystal spec

EXPOSE 3000

COPY . /code

CMD ["./todo_app"]
