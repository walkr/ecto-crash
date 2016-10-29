defmodule EctoCrash do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(EctoCrash.Repo, []),
      worker(EctoCrash.Server, [:ok, []]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EctoCrash.Supervisor]
    Supervisor.start_link(children, opts)
  end


  ########################################

  alias EctoCrash.Repo
  alias EctoCrash.User

  def create_user(params) do
    User.changeset(%User{}, params) |> Repo.insert!
    |> (fn user -> GenServer.cast(EctoCrash.Server, {:work_for_user, user}) end).()
  end

end
