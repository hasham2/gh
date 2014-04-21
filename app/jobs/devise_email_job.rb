class DeviseEmailJob
  include SuckerPunch::Job

  def perform(notification, user_id, opts)
    ActiveRecord::Base.connection_pool.with_connection do
      user = User.find(user_id)
      Devise.mailer.send(notification, user, opts).deliver
    end
  end

end
