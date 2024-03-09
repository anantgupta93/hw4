class User < ApplicationRecord
  has_many :places
  has_many :entries
end
