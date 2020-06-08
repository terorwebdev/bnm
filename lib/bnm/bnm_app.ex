defmodule Bnm.Bnm_app do
    alias Phoenix.PubSub
    alias Bnm.Bnm_lib
    alias Bnm.Bnm_pubsub
    alias BnmWeb.BnmChannel
    @pubsub_name Bnm.PubSub
    @pubsub_topic "bnm_updates"

    def update do
      data = Bnm_lib.clean_data
      set_update(data)
    end

    def get_latest do
      Bnm_pubsub.get()
    end
  
    def set_update(updates) do
      PubSub.broadcast(@pubsub_name, @pubsub_topic, {:set_update, updates})
    end

    def update_client(updates) do
      BnmChannel.send_to_channel(updates)
    end
  
end