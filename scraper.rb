#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'
require 'pry'

en_names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/Template:Peruvian_Congress_2011-2016',
  xpath: '//table//td[contains(@class,"navbox-list")]//li//a[not(@class="new")]/@title',
) 

es_names = cat = WikiData::Category.new( 'Categoría:Congresistas de Perú 2011-2016', 'es').member_titles

EveryPolitician::Wikidata.scrape_wikidata(names: { 
  es: es_names,
  en: en_names,
}, output: false)

warn EveryPolitician::Wikidata.notify_rebuilder

