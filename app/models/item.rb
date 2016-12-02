class Item < ActiveRecord::Base
  validates :title, presence: true
  validates :number, presence: true, uniqueness: { message: 'This number exists in database. Insert another number.'}

  has_many :devices
  has_many :containers

  def self.search(query)
    if(query != '')
      where("number LIKE ?", "%#{query}%")
    else
      self
    end
  end
end