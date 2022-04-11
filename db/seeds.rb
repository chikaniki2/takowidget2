# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([
  { id: 1, name: "ADMIN", description: "ADMIN ACCOUNT", admnflg: true, email: "1@gmail.com" }
])

Rule.create([
  { id: 1, name: "ナワバリ" },
  { id: 2, name: "ガチエリア" },
  { id: 3, name: "ガチホコ" },
  { id: 4, name: "ガチヤグラ" },
  { id: 5, name: "ガチアサリ" }
])

Post.create([
  { id: 1, description: "テスト投稿", user_id: 1, rule_id: 1, map_id: 1, weapon_id: 1 }
])

Map.create([
  { id: 1, name: "フジツボスポーツクラブ" },
  { id: 2, name: "ガンガゼ野外音楽堂" },
  { id: 3, name: "チョウザメ漁船" },
])

Weapon.create([
  { id: 1, name: "ワカバシューター", order: 1},
  { id: 2, name: "モミジシューター", order: 2 },
  { id: 3, name: "オチバシューター", order: 3 }
])
