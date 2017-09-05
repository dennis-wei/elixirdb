defmodule ElixirDB do
  @moduledoc """
  Driver for ElixirDB

  Handles the REPL and calling appropriate modules
  """

  @doc """
  repl()
  Driver to get user input continuously from the REPL

  Input: nothing

  Output: output of user input into REPL
    Calls subprocesses to parse the user input
  """
  def repl() do
    IO.gets("elixirdb> ")
      |> String.trim
      |> get_command
  end

  @doc """
  get_command(command)

  Input:
    command - command entered by the user
  
  Output:
    get the command and determine whether it is a SQL command or meta command,
    then call the proper function accordingly

  """
  defp get_command(command) do
    # Commands starting with # or empty commands don't do anything
    if String.match?(command, ~r/#.*/) || command == "" do
      repl_output ""
    end

    # Commands starting with . are meta commands
    if command |> String.next_codepoint |> elem(0) == "." do
      execute_meta_command(command) |> repl_output
    # Other commands are sql commands
    else
      command |> execute_sql_command |> repl_output
    end
  end

  defp repl_output({:ok, output}), do
    IO.puts output
    repl()
  end

  defp repl_output({:err_meta, command}), do
    IO.write "Unknown Meta-command: "
    IO.puts command
    repl()
  end

  defp repl_output({:err_sql, command}), do
    IO.write "Unknown SQL command: "
    IO.puts command
    repl()
  end

  defp repl_output({:err_syntax, command}), do
    IO.write "Syntax Error"
    repl()
  end
end
