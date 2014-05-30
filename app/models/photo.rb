class Photo < ActiveRecord::Base
  has_attached_file :image, styles: {medium: "217x176>", thumb: "100x100>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :photoable, polymorphic: true
end
