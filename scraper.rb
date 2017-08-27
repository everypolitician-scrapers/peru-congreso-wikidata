#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

en_names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/Template:Peruvian_Congress_2011-2016',
  xpath: '//table//td[contains(@class,"navbox-list")]//li//a[not(@class="new")]/@title',
)
es_names = cat = WikiData::Category.new( 'Categoría:Congresistas de Perú 2011-2016', 'es').member_titles

# pick up any who are no longer active (and thus not in template)
sparq = <<EOQ
  SELECT ?item WHERE {
    ?item p:P39 ?posn .
    ?posn ps:P39 wd:Q18812470 ; pq:P582 ?end .
    FILTER (?end >= "2011-07-27"^^xsd:dateTime) .
  }
EOQ
exmembers = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids:exmembers, names: { es: es_names, en: en_names, })

