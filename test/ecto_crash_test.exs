defmodule EctoCrashTest do
  use ExUnit.Case

  doctest EctoCrash

  setup_all do
    Application.ensure_all_started(:ecto_crash)
    EctoCrash.Repo.query("delete from users")
    :ok
  end

  test "insertion" do
    for x <- 1..100 do
       :ok = EctoCrash.create_user(%{username: Integer.to_string(x), profession: "dev"})
    end
  end


  test "hog" do
    for _ <- 1..1000 do
        Process.whereis(:name)
    end
  end

end
