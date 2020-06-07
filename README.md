# Bnm - Bank Negara Malaysia currency rate 

Scope

  * Pull currency rate from bnm website (bnm website will return xml file)
  * Pharse XML file using SweetXml
  * Distribute update to other nodes using pubsub architecture
  

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`

## set up distributed environment

  * Required two or more terminals to test distributed 
  * Open first terminal
  * $PORT=4000 iex --sname node1@localhost -S mix phx.server
  * by default, if you dont set port, it will use port 4000, since we need two server running, setup other server iat other terminal using different port
  * Open second terminal
  * $PORT=4001 iex --sname node2@localhost -S mix phx.server
  * iex(node2@localhost) > Node.connect(:node1@localhost)
  * The command will return true, mean its connected to the first node

### OK, lets test
  * At first terminal, fire this command
  * iex(node1@localhost)> Bnm.Bnm_app.update
  * You can see [info] Update received at: ~~~~~~~~
  * And at second terminal you will see the same info
  * To get the latest update, fire this command -> either at first terminal or others
  * iex(node2@localhost)4> Bnm.Bnm_app.get_latest

# future update
  * create website ui using vue.js
  * website subscribe to bnm channel
  * create master node, distribute to local nodes
  * create Dockerfile

