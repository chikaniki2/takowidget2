document.addEventListener('DOMContentLoaded', function () {
  // IntersectionObserverのオプション設定
  const options = {
    root: null,
    rootMargin: "-56px",
    threshold: 0.0
  };

  //IntersectionObserverのcallback関数の作成
  const callback = (entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        // 要素が交差した際の動作
        document.querySelector('.panel_io').classList.remove('io_show_margin');
        document.getElementById('io_tgt').classList.remove('io_show');
      } else {
        // 要素が交差から外れた際の動作
        document.querySelector('.panel_io').classList.add('io_show_margin');
        document.getElementById('io_tgt').classList.add('io_show');
      }
    });
  };

  const observer = new IntersectionObserver(callback, options);
  const el = document.querySelector('.panel_io');
  observer.observe(el);
});
