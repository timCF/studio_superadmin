defmodule alias StudioSuperadmin.Admin.Contacts do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudioSuperadmin.Admin.Contacts

  @derive {Poison.Encoder, except: [:__meta__]}
  @fields [:mails, :other, :phones, :social]

  embedded_schema do
    field :mails,  {:array, :string}, default: []
    field :other,  {:array, :string}, default: []
    field :phones, {:array, :string}, default: []
    field :social, {:array, :string}, default: []
  end

  def changeset(contacts = %Contacts{}, params \\ %{}) do
    contacts
    |> cast(StudioSuperadmin.Utils.model2map(params), @fields)
    |> validate_required(@fields)
    |> validate_length(:phones, min: 1)
  end

end

defmodule StudioSuperadmin.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudioSuperadmin.Admin
  alias StudioSuperadmin.Admin.Contacts

  @derive {Poison.Encoder, except: [:__meta__]}
  @simple_fields [
    :name,
    :login,
    :password,
    :enabled,
  ]
  @simple_fields_required [
    :name,
    :login,
    :password,
  ]

  schema "admins" do
    field :name,            :string
    field :login,           :string
    field :password,        :string
    field :enabled,         :boolean, default: true
    field :stamp,           :utc_datetime
    embeds_one :contacts,   Contacts, on_replace: :update
  end

  def changeset(admin, params \\ %{})
  def changeset(admin = %Admin{}, params = %{}) do
    admin
    |> case do
      %Admin{contacts: nil} -> %Admin{admin | contacts: %Contacts{}}
      %Admin{} -> admin
    end
    |> cast(StudioSuperadmin.Utils.model2map(params), @simple_fields)
    |> validate_required(@simple_fields_required)
    |> cast_embed(:contacts, [required: true])
    |> unique_constraint(:login, [name: :login])
  end

end
