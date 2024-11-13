xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "yes";

declare variable $congressInfo := doc("./utils/congress_info.xml")/api-root/congress;
declare variable $members := doc("./utils/congress_members_info.xml")//member;

<data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:noNamespaceSchemaLocation="./utils/congress_data.xsd">
  <congress>
    <name number="{normalize-space($congressInfo/number)}">
      {$congressInfo/name/text()}
    </name>
    {
      let $startDates := for $date in $congressInfo/sessions/item/startDate return xs:date(normalize-space($date))
      let $endDates := for $date in $congressInfo/sessions/item/endDate return xs:date(normalize-space($date))
      return <period from="{min($startDates)}" to="{max($endDates)}" />
    }
    <url>https://www.congress.gov</url>

    <chambers>
  {
    for $chamber in distinct-values($congressInfo/sessions/item/chamber)
    let $chamberMembers := 
      for $member in $members
      where some $term in $member/terms/item/item satisfies normalize-space(data($term/chamber)) = normalize-space(data($chamber))
      return 
        <member bioguideId="{normalize-space($member/bioguideId)}">
          <name>{normalize-space($member/name)}</name>
          <state>{normalize-space($member/state)}</state>
          <party>{normalize-space($member/partyName)}</party>
          <image_url>{normalize-space($member/depiction/imageUrl)}</image_url>
          {
            let $terms := 
              for $term in $member/terms/item/item
              where normalize-space($term/chamber) = normalize-space($chamber)
              order by $term/startYear
              return $term

            let $firstStartYear := $terms[1]/startYear
            let $lastEndYear := $terms[last()]/endYear
            return 
              <period 
                from="{normalize-space($firstStartYear)}" 
                to="{if ($lastEndYear) then normalize-space($lastEndYear) else ''}"/>
          }
        </member>
    return 
      <chamber>
        <name>{normalize-space($chamber)}</name>
        <members>
          {$chamberMembers}
        </members>
        <sessions>
          {
            for $session in $congressInfo/sessions/item
            where normalize-space($session/chamber) = normalize-space($chamber)
            return 
              <session>
                <number>{normalize-space($session/number)}</number>
                <period from="{normalize-space($session/startDate)}" to="{normalize-space($session/endDate)}"/>
                <type>{normalize-space($session/type)}</type>
              </session>
          }
        </sessions>
      </chamber>

  } 
</chambers>
  </congress>
</data>

