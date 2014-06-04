class MetricTypePolicy
  
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
  def destroy?
    @user.admin? || @user.employer?
  end
end
