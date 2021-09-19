FROM elixir:1.12.3

RUN mix local.hex --force && \
    mix archive.install --force hex phx_new 1.5.12 && \
    apt-get update && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash && \
    apt-get install -y apt-utils && \
    apt-get install -y nodejs && \
    apt-get install -y build-essential && \
    apt-get install -y inotify-tools && \
    mix local.rebar --force

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY mix.exs mix.lock ./
COPY assets/package.json assets/package-lock.json ./assets/

RUN mix do deps.get, deps.compile
RUN npm install --prefix ./assets

COPY . .

EXPOSE 4000

CMD ["mix", "phx.server"]
