.PHONY: crash

crash:
	mix ecto.drop
	mix ecto.create
	mix ecto.migrate
	mix test
