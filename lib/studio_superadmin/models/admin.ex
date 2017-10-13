defmodule StudioSuperadmin.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudioSuperadmin.Admin

  @derive {Poison.Encoder, except: [:__meta__]}
  @fields [
    :name,
    :contacts,
    :login,
    :password,
    :enabled,
  ]
  @required_fields [
    :name,
    :contacts,
    :login,
    :password,
  ]

  schema "admins" do
    field :name,      :string
    field :contacts,  :map
    field :login,     :string
    field :password,  :string
    field :enabled,   :boolean
    field :stamp,     :utc_datetime
  end

  def changeset(admin, params \\ %{})
  def changeset(admin = %Admin{}, params = %{}) do
    admin
    |> cast(StudioSuperadmin.Utils.model2map(params), @fields)
    |> validate_required(@required_fields)
    |> validate_change(:contacts, fn(:contacts, contacts) ->
      case contacts do
        %{"mails" => mails, "other" => other, "phones" => phones, "social" => social} ->
          %{mails: mails, other: other, phones: phones, social: social}
        _ ->
          contacts
      end
      |> validate_contacts
    end)
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
