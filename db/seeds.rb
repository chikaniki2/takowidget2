# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rule.create([
  { id: 1, name: "ナワバリ" },
  { id: 2, name: "ガチエリア" },
  { id: 3, name: "ガチホコ" },
  { id: 4, name: "ガチヤグラ" },
  { id: 5, name: "ガチアサリ" }
])


Map.create([
  { id: 0, name: "フジツボスポーツクラブ" },
  { id: 1, name: "ガンガゼ野外音楽堂" },
  { id: 2, name: "チョウザメ漁船" },
])

Weapon.create([
  { id: 1, name: "わかばシューター", order: 1, category: "わかばシューター" },
  { id: 2, name: "もみじシューター", order: 2, category: "わかばシューター" },
  { id: 3, name: "おちばシューター", order: 3, category: "わかばシューター" }
])

User.create([
  { id: 1, name: "testaccount", password: "WnrU4FCq4nklrh", nickname: "test_account", favorite_weapon_id: 1, admnflg: true }
])