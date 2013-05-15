#!/usr/bin/env python

from BeautifulSoup import BeautifulSoup
from urllib import urlopen, quote, unquote_plus

import sys

try:
  max_count=int(sys.argv[2])
  print "Limit set to %s" % max_count
except IndexError:
  max_count=25

try:
  search=sys.argv[1]
  print "Searching TBP for %s" % search
  ss="http://thepiratebay.se/search/%s/0/7/0" 
  ss="http://pirateproxy.net/search/%s/0/7/0" 
except IndexError:
  search="flush"
  print "Usage: tpb 'search query' [limit]"
  ss="http://thepiratebay.se/top/all?%s" 
  ss="http://pirateproxy.net/top/all?%s" 
  max_count=10




tpb=BeautifulSoup(urlopen(ss % quote(search)).read())

links=[link for link in tpb.findAll('a') if 'magnet:' in link['href']]

if max_count > len(links):
  man_count = len(links)

for l in links[0:max_count]: 
  print '-'*20
  print "%s \n" % [u for u in unquote_plus(l['href']).split('&') if 'dn' in u][0].replace("dn=", "")
  print l['href']
