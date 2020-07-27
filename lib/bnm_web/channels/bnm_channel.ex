defmodule BnmWeb.BnmChannel do
  use BnmWeb, :channel

  def send_to_channel(data) do
    Phoenix.PubSub.broadcast(
      Bnm.PubSub, 
      "bnm:lobby",
      %{type: "currency_update", payload: %{data: data}}
    )
  end


  def join("bnm:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (bnm:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  def handle_info(%{type: "currency_update"}=info, socket) do
    broadcast socket, "currency_update", info

    {:noreply, socket}
  end
end
