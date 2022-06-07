module.exports = function() {
  // IntersectionObserverのオプション設定
  const options = {
    root: null,
    rootMargin: "-58px",
    threshold: 0.0
  };
  //IntersectionObserverのcallback関数の作成
  var elmMargin = document.querySelector('.panel_io');
  var elmFloat = document.getElementById('io_tgt');
  const callback = (entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        // 要素が交差した際の動作
        elmMargin.classList.remove('io_show_margin');
        elmFloat.classList.remove('io_show');
      } else {
        // 要素が交差から外れた際の動作
        elmMargin.classList.add('io_show_margin');
        elmFloat.classList.add('io_show');
        
        // リロード時など、フロート位置がおかしい場合にリセット
        if( elmMargin.getBoundingClientRect().top > elmFloat.getBoundingClientRect().top ){
          elmMargin.classList.remove('io_show_margin');
          elmFloat.classList.remove('io_show');
        }
        
      }
    });
  };

  const observer = new IntersectionObserver(callback, options);
  const el = document.querySelector('.panel_io');
  observer.observe(el);
}
