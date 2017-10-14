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
    #
    # TODO : validate on insert
    #
  end

end

defmodule StudioSuperadmin.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudioSuperadmin.Admin

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
    field :enabled,         :boolean
    field :stamp,           :utc_datetime
    embeds_one :contacts,   StudioSuperadmin.Admin.Contacts, on_replace: :update
  end

  def changeset(admin, params \\ %{})
  def changeset(admin = %Admin{}, params = %{}) do
    plain_params = StudioSuperadmin.Utils.model2map(params)
    admin
    |> cast(plain_params, @simple_fields)
    |> validate_required(@simple_fields_required)
    |> cast_embed(:contacts, [required: true])
    |> unique_constraint(:login)
  end

  defp validate_contacts(%{mails: mails, other: other, phones: phones, social: social}) do
    contacts = [mails, other, phones, social]
    contacts
    |> Enum.filter(&(not(is_list(&1))))
    |> case do
      [] ->
        contacts
        |> List.flatten
        |> Enum.filter(&(not(is_binary(&1))))
        |> case do
          [] ->
            case length(phones) do
              0 -> [title: "at least 1 phone number is required"]
              _ -> []
            end
          some ->
            [title: "contacts values should be string type, but got #{inspect some}"]
        end
      some ->
        [title: "wrong contacts type provided #{inspect some}"]
    end
  end
  defp validate_contacts(some) do
    [title: "wrong contacts provided #{inspect some}"]
  end


end
