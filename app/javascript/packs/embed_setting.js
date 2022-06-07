  module.exports = function() {
  // trixの初期設定が重複するのを回避
  try{
   const Trix = require("trix"); 
  }catch(e){
    
  }

  if (document.getElementById('post_description')) {
    const button = document.getElementById("LinkEmbedButton")
    button.addEventListener("click", e => {
      e.preventDefault
      insertLinkcard();
    });
  }
  
  function insertLinkcard() {
    const url = prompt("please inser url Oembed");
    if (url) {
      fetchEmbbedLink(url);
    }
  }
  
  function insertAttachment(data) {
    const trixElement = document.getElementById("post_description");
    const editor = trixElement.editor
  
    const attachment = new Trix.Attachment({
      content: data.html,
      sgid: data.sgid
    });
    editor.insertAttachment(attachment);
  }
  
  function fetchEmbbedLink(url) {
    axios.post(`/embeds.json?url=${url}`)
      .then(response => {
        insertAttachment(response.data)
      }).catch(error => {
        console.error(error)
      });
  }
}
