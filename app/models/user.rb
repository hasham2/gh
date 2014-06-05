class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :async, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  

  enum role: [:employee, :employer, :admin]
  
  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>" }

  after_initialize :set_default_role, :if => :new_record?
  attr_accessor :login
  
  validates :name, uniqueness: {case_sensitive: false}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  has_many :jobs
  accepts_nested_attributes_for :jobs

  has_one :location, as: :locateable
  accepts_nested_attributes_for :location

  has_one :employer # if role == "employer"
  accepts_nested_attributes_for :employer

  has_many :photos, as: :photoable
  accepts_nested_attributes_for :photos


  has_many :work_hours
  accepts_nested_attributes_for :work_hours, allow_destroy: true
  
  acts_as_taggable 
  acts_as_taggable_on :certificates,:business_activity

  has_and_belongs_to_many :certifications


  # before_save      :set_apply_id_for_nested_objects, on: :create
  # def set_apply_id_for_nested_objects
  #   jobs.each { |user| user.job = self }
    
  # end
  

  def set_default_role
    self.role ||= :employee
  end
  
  # FROM https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider,:uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.role = :employee #this should not work for Employers
    end
  end
  
  # FROM https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
end
