defimpl ExAdmin.Authorization, for: StudioSuperadmin.Admin do
  import Ecto.Query

  def authorize_query(_defn, _conn, query, _action, _id) do
    where(query, [u], u.login != "root")
  end

  def authorize_action(_defn, conn, _action) do
    case conn.assigns[:resource] do
      %StudioSuperadmin.Admin{login: "root"} -> false
      _ -> true
    end
  end
end
