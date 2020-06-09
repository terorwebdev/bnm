# Bnm - Bank Negara Malaysia currency rate 

## Scope

  * Build app using Phoenix
  * Pull currency rate from bnm website (bnm website will return xml file)
  * Parsering XML file using SweetXml
  * Distribute update to other nodes using pubsub architecture
  

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`

 set up distributed environment

  * Required two or more terminals to test distributed 
  * Open first terminal
  * $PORT=4001 iex --sname master@localhost -S mix phx.server
  * by default, if you dont set port, it will use port 4000, since we need two server running, setup other server iat other terminal using different port
  * Open second terminal
  * $PORT=4000 iex --sname local@localhost -S mix phx.server
  * iex(node2@localhost) > Node.connect(:master@localhost)
  * The command will return true, mean its connected to the first node
  * open browser go to this url http://localhost:4000/
  
## Architecture
 <img width="468" alt="bnm_architecture" src="https://user-images.githubusercontent.com/46864338/84110384-5d27fd80-aa57-11ea-8686-9543a086ea22.png">

### OK, lets test
  * At first terminal, fire this command
  * iex(master@localhost)> Bnm.Bnm_app.update
  * You can see [info] Update received at: ~~~~~~~~
  * And at second terminal you will see the same info
  * To get the latest update, fire this command -> either at first terminal or others
  * iex(local@localhost)4> Bnm.Bnm_app.get_latest

### future update
  * create website ui using vue.js - DONE
  * website subscribe to bnm channel - DONE
  * create master node, distribute to local nodes
  * create Dockerfile

