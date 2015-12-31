#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'
require 'pry'

@pages = [
  'Categoría:Congresistas de Perú 2011-2016',
]

ids = @pages.map { |c| WikiData::Category.new(c, 'es').wikidata_ids }.flatten.uniq
ids.each_with_index do |id, i|
  puts i if (i % 20).zero?
  data = WikiData::Fetcher.new(id: id).data('es') or next
  ScraperWiki.save_sqlite([:id], data) rescue binding.pry
end

warn EveryPolitician::Wikidata.notify_rebuilder

