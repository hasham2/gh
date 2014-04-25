class CertificationPolicy
  attr_reader :user, :record
  
  def initialize(user, record)
    @user = user
    @record = record
  end
  
  def index?
    @user.admin? || @user.employer?
  end

  def create?
    @user.admin? || @user.employer?
  end

  def edit?
    @user.admin? || @user.employer?
  end

  def update?
    @user.admin? || @user.employer?
  end

end
