defmodule DI do
    @moduledoc """
    Zadanie 1, 2 - D, I
    """

    def build_DI(alphabet) do
        all = for {l1, _} <- alphabet, {l2, _} <- alphabet, do: {l1, l2}
        grouped = Enum.group_by(all, fn {a, b} -> is_dependent(alphabet[a], alphabet[b]) end)
        setD = Map.get(grouped, true, [])
        setI = Map.get(grouped, false, [])
        {setD, setI}
    end

    defp is_dependent({left1, right1}, {left2, right2}) do
        left1 == left2 || Enum.member?(right2, left1) || Enum.member?(right1, left2)
    end

end
