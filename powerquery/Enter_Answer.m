let
    Source = Csv.Document(
        File.Contents("C:\path\to\data\Enter_Answer.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedTypes = Table.TransformColumnTypes(Promoted,{
        {"time_utc4", type datetime}, {"phone_id", type text},
        {"enter", Int64.Type}, {"answer", Int64.Type}, {"connid", type text}
    }),
    AddDate = Table.AddColumn(ChangedTypes, "date", each Date.From([time_utc4]), type date),
    AddHour = Table.AddColumn(AddDate, "hour", each Time.Hour(Time.From([time_utc4])), Int64.Type)
in
    AddHour
