import {Socket} from "phoenix"
let socket = new Socket("/socket", {params: {token: window.userToken}})
socket.connect()

let regex = /[\u001b\u009b][[()#;?]*(?:[0-9]{1,4}(?:;[0-9]{0,4})*)?[0-9A-ORZcf-nqry=><]/g

let channel = socket.channel("deploy", {})
channel.join()
  .receive("ok", resp => {
    $("#btn-upgrade").click(function() {
      channel.push("upgrade", {branch: "master"})
    })

    channel.on("new:msg", res => {
      let msg = res.msg.replace(regex, '')
      $("#stream-list").append("<li>" + msg + "</li>")
      scrollTo(0, document.body.scrollHeight)
    })

  })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
