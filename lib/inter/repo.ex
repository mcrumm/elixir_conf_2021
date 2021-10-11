defmodule Inter.Repo do
  use Ecto.Repo,
    otp_app: :inter,
    adapter: Ecto.Adapters.Postgres
end
