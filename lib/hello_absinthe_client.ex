defmodule HelloAbsintheClient do
  @moduledoc """
  Documentation for `HelloAbsintheClient`.
  """

  @endpoint_url "https://api.foobar.test"
  @default_headers [
    {"accept", "application/json"},
    {"content-type", "application/json"},
    {"user-agent", "foobarservice-elixir"}
  ]

  @doc """
  Hello world.

  ## Examples

      iex> HelloAbsintheClient.hello()
      :world

  """
  def hello do
    :world
  end

  def get_widgets(query_params, limit, offset) do
    resp = Req.post!(base_req(), url: "/query", graphql: widgets_query(query_params, limit, offset))

    resp.body
  end

  defp widgets_query(query_params, limit, offset) do
    {
      """
        query ($companyId: ID!) {
          foobarWidgets() {
            count
            totalCount
            resultList {
              ownerId
              setId
              id
              title
              description
            }
          }
        }
      """,
      %{
        companyId: query_params["company_id"]
      }
    }
  end

  defp graphql_auth do
    {:bearer, Application.fetch_env!(:hello_absinthe_client, :foobar_access_token)}
  end

  def base_req do
    Req.new(method: :post, base_url: @endpoint_url, auth: graphql_auth(), headers: @default_headers)
    |> AbsintheClient.attach()
  end
end
