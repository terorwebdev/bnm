defmodule Bnm.Repo do
  use Ecto.Repo,
    otp_app: :bnm,
    adapter: Ecto.Adapters.Postgres
end
