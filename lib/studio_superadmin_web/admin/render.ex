defimpl ExAdmin.Render, for: Tuple do
  def to_string(tuple), do: inspect(tuple)
end
defimpl ExAdmin.Render, for: StudioSuperadmin.Admin.Contacts do
  def to_string(data = %StudioSuperadmin.Admin.Contacts{}) do
    data
    |> StudioSuperadmin.Utils.model2map
    |> Map.delete(:id)
    |> ExAdmin.Render.to_string
  end
end
defimpl String.Chars, for: Tuple do
  def to_string(tuple), do: inspect(tuple)
end
