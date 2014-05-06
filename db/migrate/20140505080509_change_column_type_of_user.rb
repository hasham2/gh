class ChangeColumnTypeOfUser < ActiveRecord::Migration

	def up
		execute 'ALTER TABLE users ALTER COLUMN birth_year TYPE date USING (birth_year::text::date)'
		

		change_column :users, :criminal_convictions,  'boolean USING CAST(criminal_convictions AS boolean)'
		change_column :users, :drivers_licence, 'boolean USING CAST(drivers_licence AS boolean)'
		change_column :users, :drivers_licence_class,  'boolean USING CAST(drivers_licence_class AS boolean)'
		change_column :users, :has_vehicle, 'boolean USING CAST(has_vehicle AS boolean)'
		change_column :users, :car_pool,  'boolean USING CAST(car_pool AS boolean)'
		change_column :users, :gender,  'text USING CAST(gender AS text)' 
		change_column :users, :phone_primary,  'int USING CAST(first_name AS int)' 
		change_column :users, :phone_secondary,  'int USING CAST(first_name AS int)' 
	   end
	   def down

	   	
	   	change_column :users, :car_pool,  'integer USING CAST(car_pool AS integer)'
	   	change_column :users, :has_vehicle, 'integer USING CAST(has_vehicle AS integer)'
	   	change_column :users, :drivers_licence_class,  'integer USING CAST(drivers_licence_class AS integer)'
	   	change_column :users, :drivers_licence, 'integer USING CAST(drivers_licence AS integer)'
	   	change_column :users, :criminal_convictions,  'integer USING CAST(criminal_convictions AS integer)'
	    change_column :users, :gender,  'text USING CAST(gender AS text)' 
	    change_column :users, :phone_primary,  'text USING CAST(first_name AS text)' 
	    change_column :users, :phone_secondary,  'text USING CAST(first_name AS text)' 
	    execute 'ALTER TABLE users ALTER COLUMN birth_year TYPE integer USING (birth_year::text::integer)'
	   	
	   end

end
