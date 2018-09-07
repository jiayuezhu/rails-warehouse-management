# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Description.delete_all
puts "descriptions deleted"
Buyer.delete_all
puts "buyers deleted"
Product.delete_all
puts "products deleted"
List.delete_all
puts "lists deleted"
Bill.delete_all
puts "bills deleted"
# Wholesale.delete_all
# puts "wholesales deleted"
Detail.delete_all
puts "details deleted"


# puts "start generating new seeds"

companies = ["耐克", "暴雪公司", "拳头公司", "博士", "苹果", "24小时", "可口可乐", "华为", "金正", "中华", "老板", "康师傅"]
product_categories = %w{台式电脑 笔记本 鼠标 键盘 书 笔 生活用品 食品 饼干 音箱 蓝牙耳机 插线耳机 画笔 颜料 茶叶}
product_names = %w{雷蛇超级鼠标 MacBookAir2017  MacBookPro2018  博士蓝牙音箱 Iphone6s  米奇老鼠毛绒玩具 中华牌香烟硬壳 三得利啤酒600ml装 熊博士软糖200g 大功率抽烟机 这个是什么 你想找死吗 零度可乐 英雄联盟账上手游 吕布皮肤 铁观音茶叶 康师傅方便面 你想干嘛嘛 Ak47步枪 红木长椅 SoundlinkMiniII  我爱北京天安门 名人手办20cm  三星快充 小米手机 小机器人监视 雷蛇键盘 啥表 Bilibili周边充电宝 抖音小花 钢铁是怎样炼成的 不是吧  斯伯丁篮球黑色 Soundsport AJ12}
buyers = %w{丁冬青 石田才 杜文渊 高建军 刘东 杜茜茜 吴子龙 张厂房 张学贡 付彬 李正熙 水笙 兰陵 岳武福 朱佳粤 吴志成 冯州 赵寻 梁兴利 程英燕 王云飞 贾六}
details = %w{电池容量  生产地  重量  高度}
descriptions = ["3 oz", "10 ml", "9 shots", "1 oz", "15 mm"]
quantity = (1..1000).to_a
storage = (1..20).to_a
price = (1..10000).to_a
Buyer.create(is_buyer: true, name: "lingshoukehu")
10.times do
  Buyer.create(is_buyer: false,
               name: buyers.sample)
  Buyer.create(is_buyer: true,
               name: buyers.sample)
end
puts "buyers/sellers created"

30.times do
  Product.create(name: product_names.sample,
                 model: Faker::Address.postcode,
                 brand: companies.sample,
                 color: Faker::Color.color_name,
                 category: product_categories.sample,
                 purchase_price: Faker::Number.decimal(2),
                 wholesale_labeled_price: Faker::Number.decimal(2),
                 storage: Faker::Number.between(1, 200))
end
puts "products made"

10.times do
  Bill.create(notes: Faker::Kpop.solo)
end
puts "bills made"


Bill.all.each do |b|
  a = rand(2..10)
  a.times do
    List.create(buyer_id: rand(65..84),
                bill_id: b.id)
  end
end
puts "lists made"

List.all.each do |l|
  a = rand(1..5)
  a.times do
    Wholesale.create(product_id: rand(91..120),
                     list_id: l.id,
                     quantity: Faker::Number.between(1, 200),
                     price: Faker::Number.decimal(2))
  end
end
puts "wholesales created"

details.each do |d|
  Detail.create(name: d)
end
puts "details created"

Product.all.each do |p|
  Description.create(product_id: p.id,
                     parameter: descriptions.sample,
                     detail_id: rand(14..18))
end
puts "descriptions created"









