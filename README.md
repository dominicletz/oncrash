# OnCrash

Convinence module to wrap a monitor and call a function when a process ends. Useful to setp cleanup tasks on process shutdown.

```elixir
worker = spawn(fn ->
  OnCrash.call(fn -> cleanup() end)

  do_the_work()
end) 
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `oncrash` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:oncrash, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/oncrash](https://hexdocs.pm/oncrash).

