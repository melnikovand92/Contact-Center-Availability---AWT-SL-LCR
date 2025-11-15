let
    Source = Csv.Document(
        File.Contents("C:\path\to\data\AWT_AHT.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedTypes = Table.TransformColumnTypes(Promoted,{
        {"time_utc3", type datetime}, {"phone_id", type text},
        {"aht", type number}, {"awt", type number}, {"connid", type text}
    }),
    AddDate = Table.AddColumn(ChangedTypes, "date", each Date.From([time_utc3]), type date)
in
    AddDate
