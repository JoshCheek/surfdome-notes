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
  
  create_table(:physicians)   { }
  create_table(:patients)     { }
  create_table(:appointments) do |t|
    t.integer :patient_id
    t.integer :physician_id
  end
end


# VALIDATIONS http://guides.rubyonrails.org/active_record_validations.html
class User < ActiveRecord::Base
  has_many :posts
  validates :name, exclusion: ['Josh']
end

class Post < ActiveRecord::Base
  belongs_to :user
end

user = User.new name: 'Josh'
user.errors.any?   # => false
user.valid?        # => false
user.errors.any?   # => true
user.errors[:name] # => ["is reserved"]
user.save          # => false

user.name = 'Dinesh'
user.valid?        # => true
user.errors.any?   # => false
user.errors[:name] # => []
user.save          # => true


# ASSOCIATIONS http://guides.rubyonrails.org/association_basics.html
class Physician < ActiveRecord::Base
  has_many :appointments
  has_many :patients, through: :appointments
end
 
class Appointment < ActiveRecord::Base
  belongs_to :physician
  belongs_to :patient
end
 
class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :physicians, through: :appointments
end

dr_keirnenbacher = Physician.create
dr_patel         = Physician.create
joe              = Patient.create
mei              = Patient.create

joe.appointments                      # => #<ActiveRecord::Associations::CollectionProxy []>
   .build(physician_id: dr_patel.id)  # => #<Appointment id: nil, patient_id: 1, physician_id: 2>
   .save                              # => true

mei.appointments                      # => #<ActiveRecord::Associations::CollectionProxy []>
   .create(physician_id: dr_patel.id) # => #<Appointment id: 2, patient_id: 2, physician_id: 2>





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
  
  create_table(:physicians)   { }
  create_table(:patients)     { }
  create_table(:appointments) do |t|
    t.integer :patient_id
    t.integer :physician_id
  end
end


# VALIDATIONS http://guides.rubyonrails.org/active_record_validations.html
class User < ActiveRecord::Base
  has_many :posts
  validates :name, exclusion: ['Josh']
end

class Post < ActiveRecord::Base
  belongs_to :user
end

user = User.new name: 'Josh'
user.errors.any?   # => false
user.valid?        # => false
user.errors.any?   # => true
user.errors[:name] # => ["is reserved", "is reserved"]
user.save          # => false

user.name = 'Dinesh'
user.valid?        # => true
user.errors.any?   # => false
user.errors[:name] # => []
user.save          # => true


# ASSOCIATIONS http://guides.rubyonrails.org/association_basics.html
class Physician < ActiveRecord::Base
  has_many :appointments
  has_many :patients, through: :appointments
end
 
class Appointment < ActiveRecord::Base
  belongs_to :physician
  belongs_to :patient
end
 
class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :physicians, through: :appointments
end

dr_keirnenbacher = Physician.create
dr_patel         = Physician.create
joe              = Patient.create
mei              = Patient.create

joe.appointments                      # => #<ActiveRecord::Associations::CollectionProxy []>
   .build(physician_id: dr_patel.id)  # => #<Appointment id: nil, patient_id: 1, physician_id: 2>
   .save                              # => true

mei.appointments                      # => #<ActiveRecord::Associations::CollectionProxy []>
   .create(physician_id: dr_patel.id) # => #<Appointment id: 2, patient_id: 2, physician_id: 2>

dr_keirnenbacher.appointments # => #<ActiveRecord::Associations::CollectionProxy []>
dr_patel.appointments         # => #<ActiveRecord::Associations::CollectionProxy [#<Appointment id: 1, patient_id: 1, physician_id: 2>, #<Appointment id: 2, patient_id: 2, physician_id: 2>]>

dr_keirnenbacher.patients # => #<ActiveRecord::Associations::CollectionProxy []>
dr_patel.patients         # => #<ActiveRecord::Associations::CollectionProxy [#<Patient id: 1>, #<Patient id: 2>]>



# !> [deprecated] I18n.enforce_available_locales will default to true in the future. If you really want to skip validation of your locale you can set I18n.enforce_available_locales = false to avoid this message.
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
  
  create_table(:physicians)   { }
  create_table(:patients)     { }
  create_table(:appointments) do |t|
    t.integer :patient_id
    t.integer :physician_id
  end
end


# VALIDATIONS http://guides.rubyonrails.org/active_record_validations.html
class User < ActiveRecord::Base
  has_many :posts
  validates :name, exclusion: ['Josh']
end

class Post < ActiveRecord::Base
  belongs_to :user
end

user = User.new name: 'Josh'
user.errors.any?   # => false
user.valid?        # => false
user.errors.any?   # => true
user.errors[:name] # => ["is reserved"]
user.save          # => false

user.name = 'Dinesh'
user.valid?        # => true
user.errors.any?   # => false
user.errors[:name] # => []
user.save          # => true


# ASSOCIATIONS http://guides.rubyonrails.org/association_basics.html
class Physician < ActiveRecord::Base
  has_many :appointments
  has_many :patients, through: :appointments
end
 
class Appointment < ActiveRecord::Base
  belongs_to :physician
  belongs_to :patient
end
 
class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :physicians, through: :appointments
end

dr_keirnenbacher = Physician.create
dr_patel         = Physician.create
joe              = Patient.create
mei              = Patient.create

joe.appointments                      # => #<ActiveRecord::Associations::CollectionProxy []>
   .build(physician_id: dr_patel.id)  # => #<Appointment id: nil, patient_id: 1, physician_id: 2>
   .save                              # => true

mei.appointments                      # => #<ActiveRecord::Associations::CollectionProxy []>
   .create(physician_id: dr_patel.id) # => #<Appointment id: 2, patient_id: 2, physician_id: 2>





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
  
  create_table(:physicians)   { }
  create_table(:patients)     { }
  create_table(:appointments) do |t|
    t.integer :patient_id
    t.integer :physician_id
  end
end


# VALIDATIONS http://guides.rubyonrails.org/active_record_validations.html
class User < ActiveRecord::Base
  has_many :posts
  validates :name, exclusion: ['Josh']
end

class Post < ActiveRecord::Base
  belongs_to :user
end

user = User.new name: 'Josh'
user.errors.any?   # => false
user.valid?        # => false
user.errors.any?   # => true
user.errors[:name] # => ["is reserved", "is reserved"]
user.save          # => false

user.name = 'Dinesh'
user.valid?        # => true
user.errors.any?   # => false
user.errors[:name] # => []
user.save          # => true


# ASSOCIATIONS http://guides.rubyonrails.org/association_basics.html
class Physician < ActiveRecord::Base
  has_many :appointments
  has_many :patients, through: :appointments
end
 
class Appointment < ActiveRecord::Base
  belongs_to :physician
  belongs_to :patient
end
 
class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :physicians, through: :appointments
end

dr_keirnenbacher = Physician.create
dr_patel         = Physician.create
joe              = Patient.create
mei              = Patient.create

joe.appointments                      # => #<ActiveRecord::Associations::CollectionProxy []>
   .build(physician_id: dr_patel.id)  # => #<Appointment id: nil, patient_id: 1, physician_id: 2>
   .save                              # => true

mei.appointments                      # => #<ActiveRecord::Associations::CollectionProxy []>
   .create(physician_id: dr_patel.id) # => #<Appointment id: 2, patient_id: 2, physician_id: 2>

dr_keirnenbacher.appointments # => #<ActiveRecord::Associations::CollectionProxy []>
dr_patel.appointments         # => #<ActiveRecord::Associations::CollectionProxy [#<Appointment id: 1, patient_id: 1, physician_id: 2>, #<Appointment id: 2, patient_id: 2, physician_id: 2>]>

dr_keirnenbacher.patients # => #<ActiveRecord::Associations::CollectionProxy []>
dr_patel.patients         # => #<ActiveRecord::Associations::CollectionProxy [#<Patient id: 1>, #<Patient id: 2>]>



# !> [deprecated] I18n.enforce_available_locales will default to true in the future. If you really want to skip validation of your locale you can set I18n.enforce_available_locales = false to avoid this message.
