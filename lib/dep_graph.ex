defmodule DepGraph do
    @moduledoc """
    Zadanie 4 - Minimalny graf zależności
    """

    @doc """
    Buduje minimalny graf zależności w formacie list adjacencji.
    """
    def build_dep_graph(w, setD) do
        # Dodanie wierzchołków i wszystkich krawędzi między zależnymi wierzchołkami
        adj = build_adj(w, setD)

        # Usunięcie niepotrzebnych krawędzi (transitive reduction)
        transitive_reduction(adj)
    end

    # Buduje listę adjacencji.
    defp build_adj(w, setD, i \\ 0) do
        if w == [] do
            []
        else
            [u | tail] = w
            adj_u = find_vertex_adj(u, tail, setD, i + 1)
            [adj_u | build_adj(tail, setD, i + 1)]
        end
    end

    # Szuka krawędzi wychodzących z danego wierzchołka.
    defp find_vertex_adj(u, w, setD, i) do
        if w == [] do
            []
        else
            [v | tail] = w
            if Enum.member?(setD, {u, v}) do
                [i | find_vertex_adj(u, tail, setD, i + 1)]
            else
                find_vertex_adj(u, tail, setD, i + 1)
            end
        end
    end

    # Usuwa niepotrzebne krawędzie.
    defp transitive_reduction(adj) do
        n = length(adj) - 1
        for u <- 0..n, do: vertex_transitive_reduction(u, adj, n)
    end

    defp vertex_transitive_reduction(u, adj, n) do
        adj_u = Enum.at(adj, u)
        if u >= n - 1 do
            adj_u
        else
            pairs = for x <- (u+1)..n, v <- (u+2)..n, x < v, do: {x, v}
            List.foldl(pairs, adj_u, fn {x, v}, acc ->
                if is_redundant(adj, u, x, v), do: List.delete(acc, v), else: acc end)
        end
    end

    defp is_redundant(adj, u, x, v) do
        adj_u = Enum.at(adj, u)
        adj_x = Enum.at(adj, x)

        if Enum.member?(adj_u, v) && Enum.member?(adj_u, x) && Enum.member?(adj_x, v), do: true, else: false
    end

end
