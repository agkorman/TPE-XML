xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "yes";

declare variable $invalid_argument as xs:boolean external;
declare variable $null_api_key as xs:boolean external;
declare variable $download_member_error as xs:boolean external;
declare variable $download_congress_error as xs:boolean external;

<data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:noNamespaceSchemaLocation="./utils/congress_data.xsd">
    {
    if ($invalid_argument) then
        element error{"A number between 1 and 118 must be provided as an argument."}
    else(),

    if ($null_api_key) then
        element error{"The CONGRESS_API environment variable must be set."}
    else(),

    if ($download_member_error) then
        element error{"Failed to download congress members information."}
    else(),

    if ($download_congress_error) then
        element error{"Failed to download congress information."}
    else()
    }
</data>