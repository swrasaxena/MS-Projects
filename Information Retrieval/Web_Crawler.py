import urllib.request
import urllib.parse
import re
from bs4 import BeautifulSoup
import time
import sys
import logging
from socket import timeout
import copy

if len(sys.argv) > 1:
    seed = sys.argv[1]
else:
    exit(0)

frontier_urls = [seed] #queue of frontier_urls to crawl
visited = [] #queue of visited urls 
level = 0 #depth at which the crawling takes place
visited_links = 0
interim_links = set()
colon = ":" 
hash_value = "#"
wiki_english = "http://en.wikipedia.org/wiki/"
mainpage = "http://en.wikipedia.org/wiki/Main_Page"
links_curr_level = [seed]
links_next_level = []

#function web_crawler to crawl the web pages
def web_crawler(soup, frontier_urls, seed):
    for link in soup.find_all('a', href= True):
            if hash_value not in link['href']:
                if colon not in link['href']:
                    link['href'] = urllib.parse.urljoin(seed,link['href'])
                    if mainpage not in str(link['href']): 
                        if str(link['href']).startswith(wiki_english):
                            if (link['href'] not in frontier_urls and link['href'] not in visited):
                                visited.append(link['href'])
                                frontier_urls.append(link['href'])
            else: 
                continue
    time.sleep(1)

while len(frontier_urls) > 0:
    if level == 3: 
        exit(0)        
    while len(links_curr_level) > 0:
        try:
            htmltext = urllib.request.urlopen(frontier_urls[0]).read()
            soup = BeautifulSoup(htmltext)
        except timeout:
            logging.error("Socket timeout")
            
        links_curr_level.pop(0)
        frontier_urls.pop(0)
        if len(sys.argv) == 3:
            if soup.find_all(text=re.compile(sys.argv[2], re.IGNORECASE)) == []:
                continue
        link_canonical = soup.find('link', {"rel":"canonical"})
        if link_canonical['href'] in interim_links:
            continue
        interim_links.add(link_canonical['href'])
        visited_links += 1
        f = open('Python_Links.txt', 'w')
        for c in interim_links:
            f.write(c + '\n')
        f.close()
        if len(sys.argv) > 1:
            web_crawler(soup, frontier_urls, sys.argv[1])
        else:
            print("No seed URL exists, please run the script with a seed URL")
            
    visited_links = 0
    links_next_level = copy.copy(frontier_urls)
    if len(links_curr_level) == 0:
        temp = []
        temp = copy.copy(links_curr_level)
        links_curr_level = copy.copy(links_next_level)
        links_next_level  = copy.copy(temp)
        level += 1
