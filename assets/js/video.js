
import Player from "./player"

let Video = {

  init(socket, element){
    if(!element){ return }
    let playerId = element.getAttribute("data-player-id")
    let videoId  = element.getAttribute("data-id")
    socket.connect()
    Player.init(element.id, playerId, () => { 
      this.onReady(videoId, socket)
    })
  },

  onReady(videoId, socket){
    let msgContainer = document.getElementById("msg-container")
    let msgInput     = document.getElementById("msg-input")
    let postButton   = document.getElementById("msg-submit")
    let vidChannel   = socket.channel("videos:" + videoId)

    postButton.addEventListener("click", e => {
      let payload = {body: msgInput.value, at: Player.getCurrentTime()}
      vidChannel.push("new_annotation", payload)        
                .receive("error", e => console.log(e) ) 
      msgInput.value = ""
    })

    msgContainer.addEventListener("click", e => {
      e.preventDefault()
      let seconds = e.target.getAttribute("data-seek") ||
                    e.target.parentNode.getAttribute("data-seek")
      if(!seconds){ return }

      Player.seekTo(seconds)
    })

    vidChannel.on("new_annotation", (resp) => {         
      this.renderAnnotation(msgContainer, resp)
    })

    // TODO join the vidChannel
    vidChannel.join()
//      .receive("ok", resp => console.log("joined the video channel", resp) )
      .receive("ok", ({annotations}) => {
        annotations.forEach( ann => this.renderAnnotation(msgContainer, ann) )
      })
      .receive("error", reason => console.log("join failed", reason) ) 

    //vidChannel.on("ping", ({count}) => console.log("PING", count) )
  },

//  renderAnnotation(msgContainer, {user, body, at}){
//    // TODO append annotation to msgContainer
//  }

  esc(str){ 
    let div = document.createElement("div")
    div.appendChild(document.createTextNode(str))
    return div.innerHTML
  },

  renderAnnotation(msgContainer, {user, body, at}){
    let template = document.createElement("div")
    template.innerHTML = `
    <a href="#" data-seek="${this.esc(at)}">
      [${this.formatTime(at)}]
      <b>${this.esc(user.username)}</b>: ${this.esc(body)}
    </a>
    `
    msgContainer.appendChild(template)
    msgContainer.scrollTop = msgContainer.scrollHeight
  },

  scheduleMessages(msgContainer, annotations){
    clearTimeout(this.scheduleTimer)
    this.schedulerTimer = setTimeout(() => {
      let ctime = Player.getCurrentTime()
      let remaining = this.renderAtTime(annotations, ctime, msgContainer)
      this.scheduleMessages(msgContainer, remaining)
    }, 1000)
  },

  renderAtTime(annotations, seconds, msgContainer){
    return annotations.filter( ann => {
      if(ann.at > seconds){
        return true
      } else {
        this.renderAnnotation(msgContainer, ann)
        return false
      }
    })
  },

  formatTime(at){
    let date = new Date(null)
    date.setSeconds(at / 1000)
    return date.toISOString().substr(14, 5)
  }

}

export default Video
