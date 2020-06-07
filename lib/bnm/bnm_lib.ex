defmodule Bnm.Bnm_lib do

    import SweetXml

    def clean_data do 
        case parse_data do
            {:ok, data_list} ->
                Enum.map(data_list, fn item ->
                    %{
                        "creator" => to_string(item.creator),
                        "date" => to_string(item.date),
                        "baseCurrency" => to_string(item.baseCurrency),
                        "baseUnit" => parse_base_unit(to_string(item.simpleTitle)),
                        "baseValue" => parse_base_value(parse_reverse(to_string(item.title))),
                        "targetCurrency" => to_string(item.targetCurrency),
                        "targetUnit" => parse_target_unit(parse_reverse(to_string(item.title))),
                        "targetValue" => parse_target_value(to_string(item.value)),
                        "description" => clean_string(to_string(item.description))
                    }
                end)
            {:error, _data} ->
                []
        end
    end

    #data = "0.2628 MYR = 1 EGP ( 1 MYR = 3.8054 EGP ) 2020-06-05 BNM noon mid rate"
    #return 1 MYR = 3.8054 EGP
    def parse_reverse(data) do
        data 
            |> String.split(~r|(?<=\()|) 
            |> List.last
            |> String.split(~r|(?=\))|) 
            |> List.first
            |> String.trim
    end

    # data "0.2628"
    # return 0.2628
    def parse_target_value(data) do
        String.to_float(data)
    end

    # data = "1 MYR = 3.8054 EGP"
    # return 3.8054
    def parse_base_value(data) do
        data 
            |> String.split(~r|(?<=\=.)|) 
            |> List.last
            |> String.split(" ") 
            |> List.first
            |> String.replace(",", "")
            |> String.to_float
    end

    #data = " \n   0.2628 MYR = 1 EGP ( 1 MYR = 3.8054 EGP ) 2020-06-05 BNM noon mid rate \n  "
    # return 0.2628 MYR = 1 EGP ( 1 MYR = 3.8054 EGP ) 2020-06-05 BNM noon mid rate
    def clean_string(data) do
        data
            |> String.replace("\n", "")
            |> String.trim
    end

    # data = "0.2628 MYR = 1 EGP"
    # return 1
    def parse_base_unit(data) do
        data 
            |> String.split(~r|(?<=\=.)|) 
            |> List.last
            |> String.split(" ") 
            |> List.first
            |> String.replace(",", "")
            |> String.to_integer
    end

    # data = "1 MYR = 3.8054 EGP"
    # return 1
    def parse_target_unit(data) do
        data 
            |> String.split(" ") 
            |> List.first
            |> String.to_integer
    end

    def parse_data do
        case get_data do
            {:ok, data} ->
                doc = data
                    |> xpath(~x"/rdf:RDF/item"l, 
                    title: ~x"./title/text()",
                    link:  ~x"./link/text()",
                    description: ~x"./description/text()",
                    date: ~x"./dc:date/text()",
                    language: ~x"./dc:language/text()",
                    creator: ~x"./dc:creator/text()",
                    simpleTitle: ~x"./cb:simpleTitle/text()",
                    country: ~x"./cb:country/text()",
                    baseCurrency: ~x"./cb:baseCurrency/text()",
                    targetCurrency: ~x"./cb:targetCurrency/text()",
                    value: ~x"./cb:value/text()",
                    rateType: ~x"./cb:rateType/text()",
                    application: ~x"./cb:application/text()")
                
                {:ok, doc}
            {:error, data} ->
                {:error, data}
        end
    end

    def get_data do
        case req_url do
            {:ok, {_http, _header, body}} ->
                {:ok, to_string(body)}
            {:error, _repsonse} ->
                {:error, "error request url"}
        end
    end

    def req_url do
        url = 'http://www.bnm.gov.my/index.php?tpl=fxrates.tsl'
            |> :httpc.request
    end    
end