defmodule StudioSuperadmin.ExAdmin.Admin do
  use ExAdmin.Register

  register_resource StudioSuperadmin.Admin do

    action_items except: [:delete]

    scope :all
    scope :enabled, [default: true], fn(q) ->
      where(q, [p], p.enabled == true)
    end
    scope :disabled, fn(q) ->
      where(q, [p], p.enabled == false)
    end

    index do
      selectable_column()
      column :id
      column :name
      column :login
      column :enabled
    end

    form admin do
      inputs do
        input admin, :name
        input admin, :login
        input admin, :password, type: :password
        input admin, :enabled
      end
    end

    show admin do
      attributes_table do
        row :id
        row :name
        row :login
        row :enabled
        row :contacts
      end
    end

  end

end
