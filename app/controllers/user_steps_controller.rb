class UserStepsController < ApplicationController
	include Wicked::Wizard
	steps :personal,:location,:skill,:more

	before_action :authenticate_user!

	def show
		@user = current_user
		@user.build_location
		country_states_all
        render_wizard

	end
	def update
		@user = current_user
		case step
	    when :personal
	       @user.update_attributes(user_params)          	 
	       render_wizard @user
	    when :location
	      @user.update_attributes(location_params)
	       render_wizard @user
	   else
	   	@user.update_attributes(tag_params)
	   	render_wizard @user

	  end
	end

	def tags 
		
		@tag = Cetification.all
	  respond_to do |format|
	  
	    format.json{ render :json =>@tag }
	  end
	end
	def state_response

		country_states_all
		state = params[:value]
		@states = @country[state]
	
		respond_to do |format|
		  format.json{ render :json=> @states}
		end
	
	end
	private
	def user_params
		params.require(:user).permit(:company_name,:first_name,:last_name,:phone_primary,:phone_secondary,:birth_year,:gender,:criminal_convictions,:drivers_licence_class,:drivers_licence,:has_vehicle,:car_pool)

	end
	def location_params

	  params.require(:user).permit(location_attributes: [:address,:city,:zip,:time_zone,:state])
	end
	def tag_params
		params.require(:user).permit(:tag_list,:certificate_list)
	end

		def country_states_all

			@country= {"United States" =>  
			  [["AL", "Alabama (AL)"],  
			  ["AK", "Alaska (AK)"],  
			  ["AZ", "Arizona (AZ)"],
			  ["AR", "Arkansas (AR)"],             
			  ["CA", "California (CA)"],
			  ["CO", "Colorado (CO)"],
			  ["CT", "Connecticut (CT)"],
			  ["DE", "Delaware (DE)"],
			  ["DC", "District of Columbia (DC)"],    
			  ["FL", "Florida (FL)"],
			  ["GA", "Georgia (GA)"],
			  ["GU", "Guam (GU)"],
			  ["HI", "Hawaii (HI)"],
			  ["ID", "Idaho (ID)"],
			  ["IL", "Illinois (IL)"],
			  ["IN", "Indiana (IN)"],
			  ["IA", "Iowa (IA)"],
			  ["KS", "Kansas (KS)"],
			  ["KY", "Kentucky (KY)"],
			  ["LA", "Louisiana (LA)"],
			  ["ME", "Maine (ME)"],
			  ["MD", "Maryland (MD)"],
			  ["MA", "Massachusetts (MA)"],
			  ["MI", "Michigan (MI)"],
			  ["MN", "Minnesota (MN)"],
			  ["MS", "Mississippi (MS)"],
			  ["MO", "Missouri (MO)"],
			  ["MT", "Montana (MT)"],
			  ["NE", "Nebraska (NE)"],
			  ["NV", "Nevada (NV)"],
			  ["NH", "New Hampshire (NH)"],
			  ["NJ", "New Jersey (NJ)"],
			  ["NM", "New Mexico (NM)"],
			  ["NY", "New York (NY)"],
			  ["NC", "North Carolina (NC)"],
			  ["ND", "North Dakota (ND)"],
			  ["OH", "Ohio (OH)"],
			  ["OK", "Oklahoma (OK)"],
			  ["OR", "Oregon (OR)"],
			  ["PA", "Pennyslvania (PA)"],
			  ["PR", "Puerto Rico (PR)"],
			  ["RI", "Rhode Island (RI)"],
			  ["SC", "South Carolina (SC)"],
			  ["SD", "South Dakota (SD)"],
			  ["TN", "Tennessee (TN)"],
			  ["TX", "Texas (TX)"],
			  ["UT", "Utah (UT)"],
			  ["VT", "Vermont (VT)"],
			  ["VA", "Virginia (VA)"],
			  ["VI", "Virgin Islands (VI)"],
			  ["WA", "Washington (WA)"],
			  ["WV", "West Virginia (WV)"],
			  ["WI", "Wisconsin (WI)"],
			  ["WY", "Wyoming (WY)"]],
			"Canada" =>
			  [["AB", "Alberta (AB)"],
			  ["BC", "British Columbia (BC)"],
			  ["MB", "Manitoba (MB)"],
			  ["NB", "New Brunswick (NB)"],
			  ["NL", "Newfoundland and Labrador (NL)"],
			  ["NT", "Northwest Territories (NT)"],
			  ["NS", "Nova Scotia (NS)"],
			  ["NU", "Nunavut (NU)"],
			  ["PE", "Prince Edward Island (PE)"],
			  ["SK", "Saskatchewan (SK)"],
			  ["ON", "Ontario (ON)"],
			  ["QC", "Quebec (QC)"],
			  ["YT", "Yukon (YT)"]]}
	
		end

end


  
   
   