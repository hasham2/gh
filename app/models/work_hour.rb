class WorkHour < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :day_of_week,:start_time, :end_time
	validate :start_time_must_be_before_end_time, :on => :create


	private

	def start_time_must_be_before_end_time
		return unless start_time and end_time

		if end_time < start_time 
			self.errors.add :base, 'Start Time must before the End Time'		     
		end
		
	end
end
