document.addEventListener('DOMContentLoaded', function () {
  const select_map = document.getElementById('post_map_id');
  const select_rule = document.getElementById('post_rule_id');
  const select_weapon = document.getElementById('post_weapon_id');
  const link_search_post = document.getElementById('link_search_post');
  
  link_search_post.href += '?map=' + select_map.value + '&rule=' + select_rule.value + '&weapon=' + select_weapon.value + '&category=0';

  select_map.addEventListener('change', function () {
    link_selected();
  });

  select_rule.addEventListener('change', function () {
    link_selected();
  });

  select_weapon.addEventListener('change', function () {
    link_selected();
  });

  function link_selected() {
    location.href = location.protocol + '//' + location.host + '/posts/search?map=' + select_map.value + '&rule=' + select_rule.value + '&weapon=' + select_weapon.value;
  }
});
