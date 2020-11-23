alias Graphvix.Graph, as: Graph

defmodule IOUtils do
    @moduledoc """
    Pomocnicze funkcje I/O.
    """

    def read_alphabet() do
        {c, _} = IO.gets("Liczba akcji: ") |> Integer.parse
        for i <- ?a..(?a + c - 1), tuple = read_action(List.to_string([i])),
                   into: %{}, do: {List.to_string([i]), tuple}
    end

    def read_trace() do
        IO.gets("Slowo: ") |> String.trim |> String.graphemes
    end

    def print_DI_list(label, list) do
        IO.puts ["#{label} = {", Enum.join(list |> Enum.map(fn {a, b} -> "(#{a}, #{b})" end), ", "), "}"]
    end

    def print_fnf(label, fnf) do
        IO.puts ["#{label} = [", Enum.join(fnf |> Enum.map(&Enum.join/1), "]["), "]"]
    end

    @doc """
    Zapisuje graf w formacie dot.
    """
    def write_graph(w, adj, file_name \\ "dep_graph") do
        # Wierzchołki
        {graph, indices} = List.foldl(w, {Graph.new(), []}, fn x, {graph, indices} ->
            {graph, idx} = Graph.add_vertex(graph, x)
            {graph, indices ++ [idx]} end)

        # Krawędzie
        n = length(adj)-1
        graph = List.foldl(Enum.to_list(0..n), graph, fn u, graph ->
            add_edges_vertex(graph, indices, u, Enum.at(adj, u)) end)

        Graph.write(graph, file_name)
    end

    ########## HELPERS #########
    def read_action(i) do
        instruction = IO.gets("(#{i}) ")
        trim_fun = fn (text) -> String.replace(text, ~r"[0-9 \n]", "") end
        [left, right] = String.split(instruction, "=") |> Enum.map(trim_fun)
        right = String.split(right, [",", "+", "-", "*", "/", "^"], trim: true) |> Enum.uniq
        {left, right}
    end

    defp add_edges_vertex(graph, indices, u, adj_u) do
        List.foldl(adj_u, graph, fn v, graph ->
            elem(Graph.add_edge(graph, Enum.at(indices, u), Enum.at(indices, v)), 0) end)
    end

end
