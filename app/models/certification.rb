class Certification < ActiveRecord::Base

belongs_to :certificable, polymorphic: true


end
