defmodule StudioSuperadmin.ExAdmin.Admin do
  use ExAdmin.Register

  register_resource StudioSuperadmin.Admin do
    index do
      selectable_column()
      column :id
      column :name
      column :login
      column :password
      column :enabled
      column :contacts
      actions()
    end
    form admin do
      inputs do
        input admin, :name
        input admin, :login
        input admin, :password
        input admin, :enabled
        input admin, :contacts
      end
    end
  end

end
