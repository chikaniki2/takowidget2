document.addEventListener('DOMContentLoaded', function () {
  const select_map = document.getElementById('post_map_id');
  const select_rule = document.getElementById('post_rule_id');
  const select_weapon = document.getElementById('post_weapon_id');

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
    //http://localhost:3000/posts/search?map=1&rule=1&weapon=2
  }
});
