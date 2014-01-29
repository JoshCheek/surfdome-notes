require 'active_record'
require 'logger'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
ActiveRecord::Base.logger = Logger.new $stdout
ActiveSupport::LogSubscriber.colorize_logging = false


# http://guides.rubyonrails.org/migrations.html
ActiveRecord::Schema.define do
  self.verbose = false
  
  create_table :users do |t|
    t.string :name
  end
  
  create_table :posts do |t|
    t.string :name
    t.integer :user_id
  end
end

class User < ActiveRecord::Base
  # http://guides.rubyonrails.org/association_basics.html
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end

josh      = User.new(name: 'Josh')         # => #<User id: nil, name: "Josh">
josh.save                                  # => true
josh                                       # => #<User id: 1, name: "Josh">
orest     = User.create(name: 'Orest')     # => #<User id: 2, name: "Orest">
francisco = User.create(name: 'Francisco') # => #<User id: 3, name: "Francisco">

orest.posts = [Post.new(name: "Horray for this class ;)")]
# => [#<Post id: 1, name: "Horray for this class ;)", user_id: 2>]

josh.posts = [
  Post.new(name: "Hooray, London!"), # => #<Post id: nil, name: "Hooray, London!", user_id: nil>
  Post.new(name: "Noise on 10 >.<"), # => #<Post id: nil, name: "Noise on 10 >.<", user_id: nil>
]
# => [#<Post id: 2, name: "Hooray, London!", user_id: 1>, #<Post id: 3, name: "Noise on 10 >.<", user_id: 1>]



require 'active_record'
require 'logger'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
ActiveRecord::Base.logger = Logger.new $stdout
ActiveSupport::LogSubscriber.colorize_logging = false


# http://guides.rubyonrails.org/migrations.html
ActiveRecord::Schema.define do
  self.verbose = false
  
  create_table :users do |t|
    t.string :name
  end
  
  create_table :posts do |t|
    t.string :name
    t.integer :user_id
  end
end

class User < ActiveRecord::Base
  # http://guides.rubyonrails.org/association_basics.html
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end

josh      = User.new(name: 'Josh')         # => #<User id: nil, name: "Josh">
josh.save                                  # => true
josh                                       # => #<User id: 1, name: "Josh">
orest     = User.create(name: 'Orest')     # => #<User id: 2, name: "Orest">
francisco = User.create(name: 'Francisco') # => #<User id: 3, name: "Francisco">

orest.posts = [Post.new(name: "Hooray for this class ;)")]
# => [#<Post id: 1, name: "Hooray for this class ;)", user_id: 2>]

josh.posts = [
  Post.new(name: "Hooray, London!"), # => #<Post id: nil, name: "Hooray, London!", user_id: nil>
  Post.new(name: "Noise on 10 >.<"), # => #<Post id: nil, name: "Noise on 10 >.<", user_id: nil>
]
# => [#<Post id: 2, name: "Hooray, London!", user_id: 1>, #<Post id: 3, name: "Noise on 10 >.<", user_id: 1>]


# QUERYING: http://guides.rubyonrails.org/active_record_querying.html
User.all             # => #<ActiveRecord::Relation [#<User id: 1, name: "Josh">, #<User id: 2, name: "Orest">, #<User id: 3, name: "Francisco">]>
User.first           # => #<User id: 1, name: "Josh">
User.last            # => #<User id: 3, name: "Francisco">
User.find(orest.id)  # => #<User id: 2, name: "Orest">
User.find_by_sql('select * from users')
# => [#<User id: 1, name: "Josh">, #<User id: 2, name: "Orest">, #<User id: 3, name: "Francisco">]

User.where("name = 'Orest'")         # => #<ActiveRecord::Relation [#<User id: 2, name: "Orest">]>
User.where("name = ?", orest.name)   # => #<ActiveRecord::Relation [#<User id: 2, name: "Orest">]>
Post.where(name: 'Hooray, London!')  # => #<ActiveRecord::Relation [#<Post id: 2, name: "Hooray, London!", user_id: 1>]>
Post.where(name: ['Hooray, London!', 'Hooray for this class ;)'])
# => #<ActiveRecord::Relation [#<Post id: 1, name: "Hooray for this class ;)", user_id: 2>, #<Post id: 2, name: "Hooray, London!", user_id: 1>]>
Post.all                            # => #<ActiveRecord::Relation [#<Post id: 1, name: "Hooray for this class ;)", user_id: 2>, #<Post id: 2, name: "Hooray, London!", user_id: 1>, #<Post id: 3, name: "Noise on 10 >.<", user_id: 1>]>
    .where("name like 'Hooray%'")   # => #<ActiveRecord::Relation [#<Post id: 1, name: "Hooray for this class ;)", user_id: 2>, #<Post id: 2, name: "Hooray, London!", user_id: 1>]>
    .where(user_id: josh.id)        # => #<ActiveRecord::Relation [#<Post id: 2, name: "Hooray, London!", user_id: 1>]>

# associations
Post.all                                  # => #<ActiveRecord::Relation [#<Post id: 1, name: "Hooray for this class ;)", user_id: 2>, #<Post id: 2, name: "Hooray, London!", user_id: 1>, #<Post id: 3, name: "Noise on 10 >.<", user_id: 1>]>
    .where("posts.name like 'Hooray%'")   # => #<ActiveRecord::Relation [#<Post id: 1, name: "Hooray for this class ;)", user_id: 2>, #<Post id: 2, name: "Hooray, London!", user_id: 1>]>
    .joins(:user)                         # => #<ActiveRecord::Relation [#<Post id: 1, name: "Hooray for this class ;)", user_id: 2>, #<Post id: 2, name: "Hooray, London!", user_id: 1>]>
    .where(users: {name: josh.name})      # => #<ActiveRecord::Relation [#<Post id: 2, name: "Hooray, London!", user_id: 1>]>

User.where.not(name: orest.name)
# => #<ActiveRecord::Relation [#<User id: 1, name: "Josh">, #<User id: 3, name: "Francisco">]>

User.pluck(:name)      # => ["Josh", "Orest", "Francisco"]
User.pluck(:name, :id) # => [["Josh", 1], ["Orest", 2], ["Francisco", 3]]
User.select(:name)     # => #<ActiveRecord::Relation [#<User id: nil, name: "Josh">, #<User id: nil, name: "Orest">, #<User id: nil, name: "Francisco">]>

Post.order('id asc').pluck(:user_id)  # => [2, 1, 1]
Post.order('id desc').pluck(:user_id) # => [1, 1, 2]

('a'..'z').each do |letter|
  Post.create name: letter, user_id: francisco.id
end

Post.count                # => 29
Post.limit(5).pluck(:id)  # => [1, 2, 3, 4, 5]
Post.offset(15)           # => #<ActiveRecord::Relation [#<Post id: 16, name: "m", user_id: 3>, #<Post id: 17, name: "n", user_id: 3>, #<Post id: 18, name: "o", user_id: 3>, #<Post id: 19, name: "p", user_id: 3>, #<Post id: 20, name: "q", user_id: 3>, #<Post id: 21, name: "r", user_id: 3>, #<Post id: 22, name: "s", user_id: 3>, #<Post id: 23, name: "t", user_id: 3>, #<Post id: 24, name: "u", user_id: 3>, #<Post id: 25, name: "v", user_id: 3>, ...]>
    .limit(5)             # => #<ActiveRecord::Relation [#<Post id: 16, name: "m", user_id: 3>, #<Post id: 17, name: "n", user_id: 3>, #<Post id: 18, name: "o", user_id: 3>, #<Post id: 19, name: "p", user_id: 3>, #<Post id: 20, name: "q", user_id: 3>]>
    .pluck(:id)           # => [16, 17, 18, 19, 20]

posts = Post.includes(:user).all # => [#<Post id: 1, name: "Hooray for this class ;)", user_id: 2>, #<Post id: 2, name: "Hooray, London!", user_id: 1>, #<Post id: 3, name: "Noise on 10 >.<", user_id: 1>, #<Post id: 4, name: "a", user_id: 3>, #<Post id: 5, name: "b", user_id: 3>, #<Post id: 6, name: "c", user_id: 3>, #<Post id: 7, name: "d", user_id: 3>, #<Post id: 8, name: "e", user_id: 3>, #<Post id: 9, name: "f", user_id: 3>, #<Post id: 10, name: "g", user_id: 3>, #<Post id: 11, name: "h", user_id: 3>, #<Post id: 12, name: "i", user_id: 3>, #<Post id: 13, name: "j", user_id: 3>, #<Post id: 14, name: "k", user_id: 3>, #<Post id: 15, name: "l", user_id: 3>, #<Post id: 16, name: "m", user_id: 3>, #<Post id: 17, name: "n", user_id: 3>, #<Post id: 18, name: "o", user_id: 3>, #<Post id: 19, name: "p", user_id: 3>, #<Post id: 20, name: "q", user_id: 3>, #<Post id: 21, name: "r", user_id: 3>, #<Post id: 22, name: "s", user_id: 3>, #<Post id: 23, name: "t", user_id: 3>, #<Post id: 24, name: "u", user_id: 3>, #<Post id: 25...
posts.first.user                 # => #<User id: 2, name: "Orest">

begin
  Post.transaction do
    User.create name: 'Elizabeta' # => #<User id: 4, name: "Elizabeta">
    raise 'omg!'
  end
rescue
end
User.count # => 3




# >> D, [2014-01-29T11:39:18.689849 #16369] DEBUG -- :    (0.4ms)  CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255)) 
# >> D, [2014-01-29T11:39:18.690370 #16369] DEBUG -- :    (0.1ms)  CREATE TABLE "posts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "user_id" integer) 
# >> D, [2014-01-29T11:39:18.697509 #16369] DEBUG -- :    (0.1ms)  begin transaction
# >> D, [2014-01-29T11:39:18.700031 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "users" ("name") VALUES (?)  [["name", "Josh"]]
# >> D, [2014-01-29T11:39:18.700227 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.700655 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.701026 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "users" ("name") VALUES (?)  [["name", "Orest"]]
# >> D, [2014-01-29T11:39:18.701182 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.701351 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.701609 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "users" ("name") VALUES (?)  [["name", "Francisco"]]
# >> D, [2014-01-29T11:39:18.701750 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.728458 #16369] DEBUG -- :   Post Load (1.5ms)  SELECT "posts".* FROM "posts" WHERE "posts"."user_id" = ?  [["user_id", 2]]
# >> D, [2014-01-29T11:39:18.728656 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.729979 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "Horray for this class ;)"], ["user_id", 2]]
# >> D, [2014-01-29T11:39:18.730191 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.730856 #16369] DEBUG -- :   Post Load (0.0ms)  SELECT "posts".* FROM "posts" WHERE "posts"."user_id" = ?  [["user_id", 1]]
# >> D, [2014-01-29T11:39:18.730970 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.731374 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "Hooray, London!"], ["user_id", 1]]
# >> D, [2014-01-29T11:39:18.731876 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "Noise on 10 >.<"], ["user_id", 1]]
# >> D, [2014-01-29T11:39:18.732025 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.735603 #16369] DEBUG -- :    (0.2ms)  CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255)) 
# >> D, [2014-01-29T11:39:18.735950 #16369] DEBUG -- :    (0.1ms)  CREATE TABLE "posts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "user_id" integer) 
# >> D, [2014-01-29T11:39:18.737412 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.737893 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "users" ("name") VALUES (?)  [["name", "Josh"]]
# >> D, [2014-01-29T11:39:18.738056 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.738245 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.738527 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "users" ("name") VALUES (?)  [["name", "Orest"]]
# >> D, [2014-01-29T11:39:18.738650 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.738818 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.739080 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "users" ("name") VALUES (?)  [["name", "Francisco"]]
# >> D, [2014-01-29T11:39:18.739204 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.740603 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" WHERE "posts"."user_id" = ?  [["user_id", 2]]
# >> D, [2014-01-29T11:39:18.740723 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.741188 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "Hooray for this class ;)"], ["user_id", 2]]
# >> D, [2014-01-29T11:39:18.741326 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.741842 #16369] DEBUG -- :   Post Load (0.0ms)  SELECT "posts".* FROM "posts" WHERE "posts"."user_id" = ?  [["user_id", 1]]
# >> D, [2014-01-29T11:39:18.741944 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.742294 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "Hooray, London!"], ["user_id", 1]]
# >> D, [2014-01-29T11:39:18.742642 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "Noise on 10 >.<"], ["user_id", 1]]
# >> D, [2014-01-29T11:39:18.742768 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.742973 #16369] DEBUG -- :   User Load (0.1ms)  SELECT "users".* FROM "users"
# >> D, [2014-01-29T11:39:18.744156 #16369] DEBUG -- :   User Load (0.1ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT 1
# >> D, [2014-01-29T11:39:18.744520 #16369] DEBUG -- :   User Load (0.0ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT 1
# >> D, [2014-01-29T11:39:18.744827 #16369] DEBUG -- :   User Load (0.1ms)  SELECT "users".* FROM "users" WHERE "users"."id" = ? LIMIT 1  [["id", 2]]
# >> D, [2014-01-29T11:39:18.744978 #16369] DEBUG -- :   User Load (0.0ms)  select * from users
# >> D, [2014-01-29T11:39:18.745249 #16369] DEBUG -- :   User Load (0.0ms)  SELECT "users".* FROM "users" WHERE (name = 'Orest')
# >> D, [2014-01-29T11:39:18.745503 #16369] DEBUG -- :   User Load (0.0ms)  SELECT "users".* FROM "users" WHERE (name = 'Orest')
# >> D, [2014-01-29T11:39:18.746536 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" WHERE "posts"."name" = 'Hooray, London!'
# >> D, [2014-01-29T11:39:18.747282 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" WHERE "posts"."name" IN ('Hooray, London!', 'Hooray for this class ;)')
# >> D, [2014-01-29T11:39:18.747581 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts"
# >> D, [2014-01-29T11:39:18.747868 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" WHERE (name like 'Hooray%')
# >> D, [2014-01-29T11:39:18.748149 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" WHERE (name like 'Hooray%') AND "posts"."user_id" = 1
# >> D, [2014-01-29T11:39:18.748347 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts"
# >> D, [2014-01-29T11:39:18.748773 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" WHERE (posts.name like 'Hooray%')
# >> D, [2014-01-29T11:39:18.754549 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" INNER JOIN "users" ON "users"."id" = "posts"."user_id" WHERE (posts.name like 'Hooray%')
# >> D, [2014-01-29T11:39:18.755331 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" INNER JOIN "users" ON "users"."id" = "posts"."user_id" WHERE (posts.name like 'Hooray%') AND "users"."name" = 'Josh'
# >> D, [2014-01-29T11:39:18.755718 #16369] DEBUG -- :   User Load (0.1ms)  SELECT "users".* FROM "users" WHERE ("users"."name" != 'Orest')
# >> D, [2014-01-29T11:39:18.756188 #16369] DEBUG -- :    (0.1ms)  SELECT "users"."name" FROM "users"
# >> D, [2014-01-29T11:39:18.756439 #16369] DEBUG -- :    (0.0ms)  SELECT "users"."name", "users"."id" FROM "users"
# >> D, [2014-01-29T11:39:18.756630 #16369] DEBUG -- :   User Load (0.0ms)  SELECT name FROM "users"
# >> D, [2014-01-29T11:39:18.757161 #16369] DEBUG -- :    (0.1ms)  SELECT "posts"."user_id" FROM "posts" ORDER BY id asc
# >> D, [2014-01-29T11:39:18.757458 #16369] DEBUG -- :    (0.1ms)  SELECT "posts"."user_id" FROM "posts" ORDER BY id desc
# >> D, [2014-01-29T11:39:18.757799 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.758234 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "a"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.758379 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.758585 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.759031 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "b"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.759158 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.759335 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.759640 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "c"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.759757 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.759921 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.760198 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "d"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.760324 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.760528 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.760807 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "e"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.760932 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.761131 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.761430 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "f"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.761552 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.761727 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.762068 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "g"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.762201 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.762446 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.762754 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "h"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.762880 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.763074 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.763381 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "i"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.763514 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.763705 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.763998 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "j"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.764130 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.764339 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.764621 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "k"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.764739 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.764906 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.765222 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "l"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.765351 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.765835 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.766182 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "m"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.766338 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.766530 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.766821 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "n"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.766941 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.767130 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.767606 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "o"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.767799 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.768004 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.768426 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "p"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.768587 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.768762 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.769052 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "q"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.769171 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.769347 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.769778 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "r"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.769915 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.770105 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.770423 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "s"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.770551 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.770738 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.771053 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "t"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.771188 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.771369 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.771681 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "u"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.771810 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.771998 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.772302 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "v"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.772436 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.772615 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.772914 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "w"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.773041 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.773216 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.773519 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "x"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.773645 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.773822 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.774198 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "y"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.774326 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.774511 #16369] DEBUG -- :    (0.0ms)  begin transaction
# >> D, [2014-01-29T11:39:18.774812 #16369] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "z"], ["user_id", 3]]
# >> D, [2014-01-29T11:39:18.774940 #16369] DEBUG -- :    (0.0ms)  commit transaction
# >> D, [2014-01-29T11:39:18.775363 #16369] DEBUG -- :    (0.1ms)  SELECT COUNT(*) FROM "posts"
# >> D, [2014-01-29T11:39:18.775633 #16369] DEBUG -- :    (0.1ms)  SELECT "posts"."id" FROM "posts" LIMIT 5
# >> D, [2014-01-29T11:39:18.776074 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" LIMIT -1 OFFSET 15
# >> D, [2014-01-29T11:39:18.777127 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts" LIMIT 5 OFFSET 15
# >> D, [2014-01-29T11:39:18.777758 #16369] DEBUG -- :    (0.1ms)  SELECT "posts"."id" FROM "posts" LIMIT 5 OFFSET 15
# >> D, [2014-01-29T11:39:18.778390 #16369] DEBUG -- :   Post Load (0.1ms)  SELECT "posts".* FROM "posts"
# >> D, [2014-01-29T11:39:18.783633 #16369] DEBUG -- :   User Load (0.2ms)  SELECT "users".* FROM "users" WHERE "users"."id" IN (2, 1, 3)
# >> D, [2014-01-29T11:39:18.784671 #16369] DEBUG -- :    (0.1ms)  begin transaction
# >> D, [2014-01-29T11:39:18.785360 #16369] DEBUG -- :   SQL (0.1ms)  INSERT INTO "users" ("name") VALUES (?)  [["name", "Elizabeta"]]
# >> D, [2014-01-29T11:39:18.785661 #16369] DEBUG -- :    (0.1ms)  rollback transaction
# >> D, [2014-01-29T11:39:18.786399 #16369] DEBUG -- :    (0.1ms)  SELECT COUNT(*) FROM "users"

# !> DEPRECATION WARNING: Relation#all is deprecated. If you want to eager-load a relation, you can call #load (e.g. `Post.where(published: true).load`). If you want to get an array of records from a relation, you can call #to_a (e.g. `Post.where(published: true).to_a`). (called from <main> at /Users/josh/code/JSL/surfdome/2014-01-29.rb:139)
