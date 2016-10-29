# EctoCrash

A simple Elixir app to crash Ecto-Postgrex duo.

### Run Crash

Running `make crash` will setup database and run `mix test`

**NOTE** Your postgresql database must have a user `postgres` with password `postgres`. See `config.exs`

```shell
$ mix deps.get
$ make crash
```
