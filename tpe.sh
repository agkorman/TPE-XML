info_file="./utils/congress_info.xml"
members_file="./utils/congress_members_info.xml"
output_file="congress_data.xml"
html_file="congress_page.html"

# Error control variables
error=0
invalid_argument=0
null_api_key=0
download_member_error=0
download_congress_error=0

# Argument validation
if [ $# -eq 0 ] || ! [[ "$1" =~ ^[0-9]+$ ]] || [ $1 -lt 1 ] || [ $1 -gt 118 ]
then
    echo "Error: A number between 1 and 118 must be provided as an argument."
    invalid_argument=1
    error=1
fi


# API_KEY environment variable validation
if [ -z "$CONGRESS_API" ]
then
    echo "Error: The CONGRESS_API environment variable must be set."
    null_api_key=1
    error=1
fi


if [ $error -eq 0 ]
then
    congress_number=$1

    # Fetch congress information
    echo "Downloading information for Congress number ${congress_number}..."
    if ! curl -s -f -X GET "https://api.congress.gov/v3/congress/${congress_number}?format=xml&api_key=${CONGRESS_API}" -H "accept: application/xml" -o "$info_file"; then
        echo "Error: Failed to download congress information."
        download_congress_error=1
        error=1
    fi
fi
if [ $error -eq 0 ]
then
    # Fetch congress members information
    echo "Downloading congress members information..."
    if ! curl -s -f -X GET "https://api.congress.gov/v3/member/congress/${congress_number}?format=xml&currentMember=false&limit=500&api_key=${CONGRESS_API}" -H "accept: application/xml" -o "$members_file"; then
        echo "Error: Failed to download congress members information."
        download_member_error=1
        error=1
    fi
fi

# Exit if there were any errors
if [ $error -eq 1 ]
then
    java net.sf.saxon.Query ./utils/error_handler.xq "invalid_argument=$invalid_argument" "null_api_key=$null_api_key" "download_member_error=$download_member_error" "download_congress_error=$download_congress_error" -o:"$output_file"
    java net.sf.saxon.Transform -s:"$output_file" -xsl:./utils/generate_error_html.xsl -o:"$html_file"
    exit 1
fi

# Run data extraction with XQuery
echo "Processing data with XQuery..."
java net.sf.saxon.Query ./extract_congress_data.xq -o:"$output_file"


# Transform XML to HTML using XSLT
echo "Generating HTML page..."
java net.sf.saxon.Transform -s:"$output_file" -xsl:./generate_html.xsl -o:"$html_file"


echo "Process completed successfully. Generated files:"
echo "- XML data file at $output_file"
echo "- HTML page at $html_file"
