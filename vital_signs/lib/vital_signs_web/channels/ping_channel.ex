defmodule VitalSignsWeb.PingChannel do
  use Phoenix.Channel

  def join(_topic, _payload, socket) do
    {:ok, socket}
  end


  def handle_in("ping:" <> ping, _payload, socket) do
    {:ok, {:ok, %{ping: ping}}, socket}
  end

  def handle_in("ping", %{"abc" => abc}, socket) do
    {:reply, {:ok, %{abc: abc}}, socket}
  end

  def handle_in("ping", _payload, socket) do
    {:reply, {:ok, %{ping: "pong"}}, socket}
  end

  intercept ["request_ping"]

  def handle_out("request_ping", _payload, socket) do

    {:noreply, socket}
  end


end
