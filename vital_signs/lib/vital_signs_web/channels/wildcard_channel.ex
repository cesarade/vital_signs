defmodule VitalSignsWeb.WildcardChannel do
  use Phoenix.Channel

  def join("wild:" <> number, _payload, socket) do
    IO.puts(number)
    {:ok, socket}
  end
end
