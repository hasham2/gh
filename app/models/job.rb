class Job < ActiveRecord::Base
  belongs_to :user #Employer

  has_and_belongs_to_many :certifications, dependent: :destroy
  accepts_nested_attributes_for :certifications

  has_and_belongs_to_many :requirements, dependent: :destroy
  accepts_nested_attributes_for :requirements

  has_and_belongs_to_many :metrics, dependent: :destroy
  accepts_nested_attributes_for :metrics, allow_destroy: true

  has_many :photos, as: :photoable, dependent: :destroy
  accepts_nested_attributes_for :photos

  has_one :location, as: :locateable, dependent: :destroy
  accepts_nested_attributes_for :location



   def self.my_search(max_distance, address, hourly_pay, fixed_price,earliest_start_date, max_days_listed, job_level, req_ids,certifications_and_requirements_ids)

    unless max_distance.blank?
      @jobs = Array.new
      @locations_of_jobs = Location.near(address, max_distance,{:units => :km}).where(:locateable_type=>'Job')
      
      @locations_of_jobs.collect do |l| 
        if l.locateable.present?
            @jobs << l.locateable
        end
      end

        if @jobs.blank?
          return @jobs     
        end
    end

   unless hourly_pay.blank?
      hourly_pay_based_jobs = Array.new
      # binding.pry 
     @jobs.collect do |j|
        if j.desired_wage.present? && j.desired_wage >= hourly_pay.to_f
         hourly_pay_based_jobs << j 
        end
      end
      @jobs = hourly_pay_based_jobs
   end

   unless fixed_price.blank?
      fixed_price_based_jobs = Array.new
      # binding.pry 
     @jobs.collect do |j|
        if j.fixed_price.present? && j.fixed_price == fixed_price.to_f
         fixed_price_based_jobs << j 
        end
      end
      @jobs = fixed_price_based_jobs
   end

   unless max_days_listed.blank?
    max_days_listed_based_jobs = Array.new
         now = Date.today
         days_listed = now - max_days_listed.to_i  

    @jobs.collect do |j|
       if j.created_at.present?  && j.created_at >= days_listed
        max_days_listed_based_jobs << j 
       end
     end

     @jobs = max_days_listed_based_jobs
   end

    unless earliest_start_date.blank?
     earliest_start_date_based_jobs = Array.new

      month = earliest_start_date.split('/')[0].to_i
      day = earliest_start_date.split('/')[1].to_i
      year = earliest_start_date.split('/')[2].to_i
      earliest = Date.new(year,month,day)
     @jobs.collect do |j|
        if j.start_date.present?  && j.start_date >= earliest
         earliest_start_date_based_jobs << j 
        end
      end

      @jobs = earliest_start_date_based_jobs
    end

    unless job_level.blank?
      job_level_based_jobs = Array.new
     # @jobs = @jobs.where(:job_level=>job_level)
     @jobs.collect do |j|
        if j.job_level.present? && j.job_level == job_level
         job_level_based_jobs  << j 
        end
      end
      @jobs = job_level_based_jobs
      # binding.pry    
    end

    unless req_ids.blank?

       req_based_jobs = Array.new
           @jobs.each do |j|
              if j.requirements.present?
                req_ids.each do |r_i|
                   # binding.pry 
                  j.requirements.each do |r|
                    if r.id == r_i.to_i  
                    req_based_jobs << j                        
                    end
                  end    
                end 
              end
          end          
      @jobs = req_based_jobs.uniq
    end
    
    unless certifications_and_requirements_ids.blank?
         # binding.pry
       certifications_and_requirements_based_jobs = Array.new
           @jobs.each do |j|
            # binding.pry
              if j.certifications.present? or j.requirements.present?
                certifications_and_requirements_ids.each do |r_i|
                  j.certifications.each do |r|
                    if r.id == r_i.to_i  
                    certifications_and_requirements_based_jobs << j                        
                    end
                  end    
                end 
                certifications_and_requirements_ids.each do |r_i|
                  j.requirements.each do |r|
                    if r.id == r_i.to_i  
                    certifications_and_requirements_based_jobs << j                        
                    end
                  end    
                end 
              end
          end   
          # binding.pry        
      @jobs = certifications_and_requirements_based_jobs.uniq
       # binding.pry 
    end


   # binding.pry
  return @jobs
 end


end
