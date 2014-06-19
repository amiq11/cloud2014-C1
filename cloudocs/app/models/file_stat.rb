class FileStat < ActiveRecord::Base
  validates :name, :uniqueness => true
end
