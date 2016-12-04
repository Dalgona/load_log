# LoadLog

LoadLog is a simple OTP application that records CPU load average data.

Please refer to the documentation for usage and configuration.

## Usage

1. Add `:load_log` into `deps` in your `mix.exs`.

    ```elixir
    defp deps do
      [ ...
       {:load_log, "~> 0.1.0"},
        ... ]
    end
    ```

2. Add `:load_log` into the application list.

    ```elixir
    def application do
      [applications: [:load_log, ... ],
       ... ]
    end
    ```

# LICENSE

MIT License. Please read `LICENSE` file for the full text.

