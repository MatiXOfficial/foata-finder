defmodule FNFGraph do
    @moduledoc """
    Zadanie 5 - FNF na podstawie grafu zależności
    """

    @doc """
    Znajduje postać Foaty na podstawie słowa i grafu zależności.
    """
    def find_fnf(w, adj) do
        dist = for _ <- 0..(length(w)-1), do: 0
        dist = List.foldl((for u <- 0..(length(w)-1), do: u), dist, fn u, dist ->
            update_disc_vertex(adj, u, dist)
        end)

        Enum.zip(dist, w) |> Enum.sort() |> Enum.chunk_by(fn {class, _} -> class end)
            |> Enum.map(fn list -> Enum.map(list, fn {_, l} -> l end) end)
    end

    defp update_disc_vertex(adj, u, dist) do
        adj_u = Enum.at(adj, u)
        inc_dist = Enum.at(dist, u) + 1
        List.foldl(adj_u, dist, fn v, dist ->
            dist_v = Enum.at(dist, v)
            if inc_dist <= dist_v do
                dist
            else
                List.replace_at(dist, v, inc_dist)
            end
        end)
    end

end
