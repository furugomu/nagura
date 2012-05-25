class Rank < ActiveRecord::Base
  attr_accessible :name
  default_scope order("#{quoted_table_name}.id desc")
end
