require 'active_record'
# require 'logger'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
# ActiveRecord::Base.logger = Logger.new $stdout
# ActiveSupport::LogSubscriber.colorize_logging = false

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
  has_many :posts
  # VALIDATIONS http://guides.rubyonrails.org/active_record_validations.html
  validates :name, exclusion: ['Josh']
end

class Post < ActiveRecord::Base
  belongs_to :user
end

user = User.new name: 'Josh'
user.errors.any?  # => false
user.valid?       # => false
user.errors.any?  # => true
user.errors[:name]# => ["is reserved"]
user.save         # => false

user.name = 'Dinesh'
user.valid?       # => true
user.errors.any?  # => false
user.errors[:name]# => []
user.save         # => true




# !> [deprecated] I18n.enforce_available_locales will default to true in the future. If you really want to skip validation of your locale you can set I18n.enforce_available_locales = false to avoid this message.
