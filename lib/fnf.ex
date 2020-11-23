defmodule FNF do
    @moduledoc """
    Zadanie 3 - fnf
    """

    @doc """
    Znajduje postać Foaty na podstawie słowa i zbioru zależności.
    """
    def find_fnf(w, setD) do
        if w == [] do
            :empty
        else
            [u | tail] = w
            depSet = update_dep_set(u, setD)
            {fnf_el, tail} = extend_fnf_element(u, tail, setD, depSet)
            fnf_el = [u | fnf_el] |> Enum.sort()
            rest = find_fnf(tail, setD)
            if rest == :empty do
                [fnf_el]
            else
                [fnf_el | find_fnf(tail, setD)]
            end
        end
    end

    defp update_dep_set(u, setD, depSet \\ MapSet.new()) do
        List.foldl(setD, depSet, fn {x, y}, depSet ->
            if x == u do
                MapSet.put(depSet, y)
            else
                depSet
            end
        end)
    end

    defp extend_fnf_element(u, w, setD, depSet) do
        if w == [] do
            {[], []}
        else
            [v | tail] = w
            {res_fnf_el, res_w} = extend_fnf_element(u, tail, setD, update_dep_set(v, setD, depSet))
            if MapSet.member?(depSet, v) do
                {res_fnf_el, [v | res_w]}
            else
                {[v | res_fnf_el], res_w}
            end
        end
    end

end
