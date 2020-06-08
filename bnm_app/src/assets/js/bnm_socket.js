import { Socket } from "../phoenix/phoenix"

let wsserver = "ws://" + window.location.hostname + ":4000";

let socket = new Socket(wsserver + "/socket", {
    logger: (kind, msg, data) => {
        console.log(`${kind}: ${msg}`, data);
    },
    transport: WebSocket
});
socket.connect();

// let channel = socket.channel("bnm:lobby", {})
// channel.join()
//     .receive("ok", resp => { console.log("Joined successfully", resp) })
//     .receive("error", resp => { console.log("Unable to join", resp) })

export default socket