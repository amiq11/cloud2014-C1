class FileStat < ActiveRecord::Base
  validates :name, :uniqueness => true
  validates :name, :format => {with: /\A[^\/\0]+\Z/} # ファイル名に"/","\0"は使用禁止
end
