class Word < ActiveRecord::Base
 attr_accessible :keyword, :discription
 validates_presence_of :keyword, :discription
end
