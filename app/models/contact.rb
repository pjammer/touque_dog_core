class Contact < Tableless 
        column :name,          :string 
        column :city,          :string 
        column :state,         :string 
        column :phone,         :string 
        column :email_address, :string 
        column :address,       :string 
        column :zip,           :string 
        column :message,       :text 
 
 validates_presence_of :name, :email_address, :message 
end