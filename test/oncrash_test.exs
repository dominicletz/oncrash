defmodule OnCrashTest do
  use ExUnit.Case
  doctest OnCrash

  test "process ends nicely" do
    me = self()

    spawn(fn ->
      # with reason
      OnCrash.call(fn reason ->
        send(me, {:end_message, reason})
      end)

      # without reason
      OnCrash.call(fn ->
        send(me, :end_message)
      end)
    end)

    receive do
      {:end_message, reason} -> assert :normal == reason
    after
      1000 -> assert false
    end

    receive do
      :end_message -> assert true
    after
      1000 -> assert false
    end
  end

  test "process throw" do
    me = self()

    spawn(fn ->
      # with reason
      OnCrash.call(fn reason ->
        send(me, {:end_message, reason})
      end)

      # without reason
      OnCrash.call(fn ->
        send(me, :end_message)
      end)

      throw(:oh_no!)
    end)

    receive do
      {:end_message, reason} -> assert {{:nocatch, :oh_no!}, _backtrace} = reason
    after
      1000 -> assert false
    end

    receive do
      :end_message -> assert true
    after
      1000 -> assert false
    end
  end

  test "process raise" do
    me = self()

    spawn(fn ->
      # with reason
      OnCrash.call(fn reason ->
        send(me, {:end_message, reason})
      end)

      # without reason
      OnCrash.call(fn ->
        send(me, :end_message)
      end)

      raise "oh_no!"
    end)

    receive do
      {:end_message, reason} -> assert {%RuntimeError{message: "oh_no!"}, _backtrace} = reason
    after
      1000 -> assert false
    end

    receive do
      :end_message -> assert true
    after
      1000 -> assert false
    end
  end

  test "process exit" do
    me = self()

    for killer <- [:oh_no!, :exit, :normal, :kill] do
      spawn(fn ->
        # with reason
        OnCrash.call(fn reason ->
          send(me, {:end_message, reason})
        end)

        # without reason
        OnCrash.call(fn ->
          send(me, :end_message)
        end)

        exit(killer)
      end)

      receive do
        {:end_message, reason} -> assert killer == reason
      after
        1000 -> assert false
      end

      receive do
        :end_message -> assert true
      after
        1000 -> assert false
      end
    end
  end
end
