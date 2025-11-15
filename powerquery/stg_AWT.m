let
    Source = #"AWT_AHT",                          // ссылка на существующий запрос AWT_AHT
    Keep = Table.SelectColumns(Source, {"connid","awt"}),
    Dedup = Table.Distinct(Keep, {"connid"})
in
    Dedup
