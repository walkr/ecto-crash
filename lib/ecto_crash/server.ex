defmodule EctoCrash.Server do

    use GenServer
    import Ecto.Query
    alias EctoCrash.Repo
    alias EctoCrash.User

    ################################################################
    ### INITIALIZATION
    ################################################################

    def start_link(args, _opts) do
        GenServer.start_link(__MODULE__, args, name: EctoCrash.Server)
    end

    def init(:ok) do
        {:ok, :state}
    end

    ################################################################
    ### CALLS
    ################################################################

    @doc """
    Respond to pings
    """
    def handle_call(:ping, _from, state) do
        {:reply, :pong, state}
    end

    ################################################################
    ### CASTS
    ################################################################

    @doc """
    Update a stream
    """
    def handle_cast({:work_for_user, user}, state) do
        spawn(__MODULE__, :after_create, [user])
        {:noreply, state, state}
    end

    ################################################################

    def after_create(user) do
        IO.puts "Work, work, work, work, work! id: #{user.id}"
        for u <- similar(user) do
            for x <- similar(u) do
                IO.puts "Found similar user = #{inspect x.id}"
            end
        end
    end

    def similar(user) do
        query = from u in User,
        where: u.id != ^user.id,
        select: u, distinct: u.id
        Repo.all(query)
    end

end