defmodule Zad5 do
    @moduledoc """
    Głowny moduł projektu
    """

    ########## Interfejs ##########
    # Główna funkcja uruchamiająca program
    def run do
        {_, setD, _} = handle_alphabet()
        handle_trace(setD)
    end

    ########## Funkcje pomocnicze ##########
    def handle_alphabet do
        IO.puts("===================")
        IO.puts("===== ALFABET =====")
        IO.puts("===================")
        alphabet = IOUtils.read_alphabet

        # 1. D, 2. I
        IO.puts("-------------------")
        {setD, setI} = DI.build_DI(alphabet)
        IOUtils.print_DI_list("D", setD)
        IOUtils.print_DI_list("I", setI)
        {alphabet, setD, setI}
    end

    defp handle_trace(setD) do
        IO.puts("================")
        IO.puts("===== SLAD =====")
        IO.puts("================")
        w = IOUtils.read_trace

        # 3. fnf
        fnf = FNF.find_fnf(w, setD)
        IOUtils.print_fnf("FNF na podstawie sladu", fnf)

        # 4. graph
        adj = DepGraph.build_dep_graph(w, setD)
        IOUtils.write_graph(w, adj, "dep_graph")
        IO.puts("Graf zostal zapisany w pliku dep_graph.dot.")

        # 5. fnf na podstawie grafu
        fnf = FNFGraph.find_fnf(w, adj)
        IOUtils.print_fnf("FNF na podstawie grafu", fnf)
    end

end
