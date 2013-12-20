defmodule DownloadCodeword do

  import String, only: [from_char_list!: 1]


  def main([yyyy, mm, dd]) do

    {:ok, body} = fetch_codeword({yyyy, mm, dd})

    # For some reason, they send back XML in a javascript wrapper...
    << %s{var CrosswordPuzzleData = \"} <> xml >> = body
    xml = Regex.replace(%r/\";\z/, xml, "")
    xml = Regex.replace(%r/\\\"/, xml, "\"")

    {:ok, {_, hints}, _} = :erlsom.parse_sax(xml, {_cells = HashDict.new, _hints = HashDict.new}, &handler/2)
    hints |> Enum.each(fn {code, letter} -> IO.puts "#{code}=#{letter}" end)
  end

  def handler({:startElement, _, 'cell', _, attrs}, {cells, hints}) do
    attrs = to_hash(attrs)
    cond do
      Dict.has_key?(attrs, "type") -> nil
      true ->
        x = binary_to_integer(attrs["x"])
        y = binary_to_integer(attrs["y"])
        cells = Dict.put(cells, {x,y}, attrs["number"])
        if attrs["hint"] do
          hints = Dict.put(hints, attrs["number"], attrs["solution"])
        end
    end
    {cells,hints}
  end

  def handler({:startElement, _, 'word', _, attrs}, {cells, hints}) do
    attrs = to_hash(attrs)
    xs = get_range(attrs["x"])
    ys = get_range(attrs["y"])
    codes = lc x inlist xs, y inlist ys, do: cells[{x,y}]
    IO.puts Enum.join(codes, " ")
    {cells, hints}
  end

  def handler(_, acc) do
    acc
  end

  def get_range(str) do
    [s,e] = case Regex.split(%r/-/, str) do
              [x]   -> [x,x]
              [s,e] -> [s,e]
            end

    s = binary_to_integer(s)
    e = binary_to_integer(e)
    s..e |> Enum.to_list
  end

  def to_hash(attrs) do
    attrs
    |> Enum.map(fn {:attribute, name, _, _, value} -> { from_char_list!(name), from_char_list!(value) } end)
    |> HashDict.new
  end

  alias HTTPotion.Response

  @user_agent  [ "User-agent": "Elixir dave@pragprog.com"]

  def fetch_codeword(yyyymmdd) do
    HTTPotion.start
    case HTTPotion.get(codeword_url(yyyymmdd), @user_agent) do
      Response[body: body, status_code: status, headers: _headers ] 
      when status in 200..299 ->
        { :ok, body }
      Response[body: body, status_code: _status, headers: _headers ] ->
        { :error, body }
    end
  end

  def codeword_url({yyyy, mm, dd}) do
    "http://bestforpuzzles.com/daily-codewords/puzzles/#{yyyy}-#{mm}/cb1-#{yyyy}-#{mm}-#{dd}.js"
  end

end
