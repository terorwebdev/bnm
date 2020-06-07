defmodule Bnm.Bnm_pubsub do
    use GenServer
    alias Phoenix.PubSub
    require Logger
    @pubsub_name Bnm.PubSub
    @pubsub_topic "bnm_updates"
  
    def start_link(_state \\ []) do
      GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end
  
    def get() do
      GenServer.call(__MODULE__, :get)
    end
  
    def init(state) do
      PubSub.subscribe(@pubsub_name, @pubsub_topic)
      state = []
      {:ok, state}
    end 
  
    def handle_call(:get, _, state) do
      {:reply, state, state}
    end
  
    def handle_info({:set_update, updates}, state) do
      Logger.info("Update received at: #{inspect(NaiveDateTime.utc_now)}")
      #Logger.info("Update received: #{inspect(updates)}")
  
      {:noreply, updates}
    end
    
  end
  