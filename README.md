# Converter Tsv and Json

# libs
 - path: ^1.9.0
 - collection: ^1.19.1
 - pretty_json: ^2.0.0
 - csv: ^6.0.0

## Install Libs
When you run the code, it automatically install the dependencies. 

# How use

Convert to TSV is easy just run the script abouve:
## Convert Tsv to Json
```
dart run bin/script_convert_json_csv.dart tsv products-demo.tsv.example
```

they will tacke your table tsv like this:

| first |  second  | third |
|:-----|:--------:|------:|
| nome   | titulo | descricao |
| nome-2   |  alguma coisa  |   ok |

to this:

```json
{
    "nome": {
        "second": "titulo",
        "third": "descricao"
    },
    "nome-2": {
         "second": "alguma coisa",
        "third": "ok"
    }

}
```

## Convert Json to Tsv
That have some of hardcoded to convert to tsv, because i need change create a header of the table, so this need to be changed on code if you need just convert json to tsv. 

```
dart run bin/script_convert_json_csv.dart json products-example.json
```