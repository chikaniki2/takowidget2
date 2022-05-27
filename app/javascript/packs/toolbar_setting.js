document.addEventListener("DOMContentLoaded", function () {

  document.querySelector('.trix-button-group--text-tools').remove();
  document.querySelector('.trix-button-group--block-tools').remove();

  window.addEventListener("trix-file-accept", function (event) {
    // 画像の拡張子をチェック
    const acceptedTypes = ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'];
    if (!acceptedTypes.includes(event.file.type)) {
      event.preventDefault();
      alert("添付できる拡張子は、jpg、jpeg、png、gifのみです");
    }
    // 画像のbyte数をチェック
    const maxFileSize = 1024 * 1024 * 2 // 2MB 
    if (event.file.size > maxFileSize) {
      event.preventDefault();
      alert("アップできる画像は2MBまでです。");
    }
  })

});
