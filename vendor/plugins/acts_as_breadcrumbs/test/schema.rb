ActiveRecord::Schema.define(:version => 1) do

  create_table :nodes, :force => true do |t|
    t.column :parent_id, :integer
    t.column :name, :string
    t.column :breadcrumbs, :string
  end

  create_table :locations, :force => true do |t|
    t.column :parent_id, :integer
    t.column :name, :string
    t.column :location_string, :string
  end

  create_table :soldiers, :force => true do |t|
    t.column :parent_id, :integer
    t.column :name, :string
    t.column :chain_o_command, :string
  end

  create_table :web_pages, :force => true do |t|
    t.column :parent_id, :integer
    t.column :title, :string
    t.column :slug, :string
    t.column :url, :string
    t.column :breadcrumbs, :string
  end

end