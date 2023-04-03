(: 1. Return the area of Mongolia. :)

(: Reminder: To return the value of an attribute attr, you must use data(@attr), although just @attr may be used in comparisons. You will need to remember this for some later questions as well. :)

//country[@name = "Mongolia"]/data(@area),


(: 2. Return the average population of Russian-speaking countries. :)

avg(//country[language = 'Russian']/data(@population)),

(: 3. Return the number of countries where Russian is spoken. :)

count(//country[language = 'Russian']),


(: 4. Return the population density of Qatar. Note: Since the "/" operator has its own meaning in XPath and XQuery, the division operator is "div". To compute population density use "(@population div @area)". :)

//country[@name = 'Qatar']/(@population div @area),

(: 5. Return the names of all countries where a city in that country contains more than one-third of the country's population. :)

//country[city/population > (@population div 3)]/data(@name)



(: 6. Return the names of all countries with population greater than 100 million. :)
let $countries := /countries/country
for $c in $countries
  where $c/data(@population) > 100000000
  return $c/data(@name)

(: 7. Create a list of French-speaking and German-speaking countries. The result should take the form: :)

(:
<result>
  <French>
    <country>country-name</country>
    <country>country-name</country>
    ...
  </French>
  <German>
    <country>country-name</country>
    <country>country-name</country>
    ...
  </German>
</result>
:)

let $countries := //country
return
  <result>
    <French>
      {
        for $country in $countries[language = 'French']
        return
          <country>{ $country/data(@name) }</country>
      }
    </French>
    <German>
      {
        for $country in $countries[language = 'German']
        return
          <country>{ $country/data(@name) }</country>
      }
    </German>
  </result>

(: 8. Return the name of the country with the highest population. :)

let $countries := /countries
return $countries/*[@population =  max($countries/country/data(@population))]/data(@name)

(: 9. Return the countries with the highest and lowest population densities. You can assume densities are unique. The result should take the form:

<result>
  <highest density="value">country-name</highest>
  <lowest density="value">country-name</lowest>
</result>:)

let $countries                    := //country
let $population_density           := $countries/(@population div @area)
let $highest_density              := max($population_density)
let $country_with_highest_density := $countries[(@population div @area) = $highest_density]
let $lowest_density               := min($population_density)
let $country_with_lowest_density  := $countries[(@population div @area) = $lowest_density]
return
  <result>
    <highest density="{ $highest_density }">
      { $country_with_highest_density/data(@name) }
    </highest>
    <lowest density="{ $lowest_density }">
      { $country_with_lowest_density/data(@name) }
    </lowest>
  </result>

(: 10. Return all country-language pairs where the language is spoken in the country and the name of the country textually contains the language name. Return each pair as a country element with language attribute, e.g., <country language="French">French Guiana</country> :)

for $country in //country
for $language in $country/language[contains(../data(@name), .)]
return
  <country language="{ data($language) }">
    { $country/data(@name) }
  </country>