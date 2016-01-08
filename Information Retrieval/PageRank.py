'''
Created on Oct 9, 2014

@author: Swra
'''
import sys
from collections import defaultdict
import math
import operator

inlinks_dict = defaultdict(set)
outlinks_dict = defaultdict(set)
all_pages = set()
pageRank = {}
newPR = {}
sinkNodes = set()
d = 0.85
sortedPR = {}
sortedIL = {}
inlinks = {}
f = open(sys.argv[1]).readlines()

#Reads the file and creates dictionary of inlinks and outlinks
for line in f:
    entries =  line.split()
    toLink = entries[0]
    all_pages.add(toLink)
    fromList =  entries[1:]
    for fromLink in fromList:
        inlinks_dict[toLink].add(fromLink)
        outlinks_dict[fromLink].add(toLink)
        all_pages.add(fromLink)

total = len(all_pages)

#Initialize page rank as per pseudo code 1/N 
for elem in all_pages:
    pageRank[elem] = 1/float(total)

#Determine sink nodes in the given system
for key in inlinks_dict.keys():
        if outlinks_dict.__contains__(key) == False:
            sinkNodes.add(key)

#Calculate perplexity of each page via PR
def perplexity_calc(pageRank):
    ent = 0
    for pr in pageRank.values():
        ent += pr*math.log(1/pr,2)
    p = math.pow(2,ent)
    return p

curr_perpl = perplexity_calc(pageRank)
prev_perpl = 0

#Pseudo code to calculate the pagerank of a page
count=0
while count <= 3:
    print ('Current Perplexity is -> ' + str(curr_perpl))
    if abs(curr_perpl-prev_perpl) < 1:
        count += 1
    else:
        count = 0
    sinkPR = 0
    for sink in sinkNodes:
        sinkPR += pageRank[sink]
    for page in all_pages:
        newPR[page] = (1-d)/total
        newPR[page] = newPR[page] + ((d*sinkPR)/total)
        for link in inlinks_dict[page]:
            newPR[page] += (d*pageRank[link]/(len(outlinks_dict[link])))
    for page in all_pages:
        pageRank[page] = newPR[page]
    prev_perpl = curr_perpl
    curr_perpl = perplexity_calc(pageRank)
    count += 1

#Sorts the page ranks and gets top 50
sortedPR = (sorted(pageRank.items(),key=operator.itemgetter(1), reverse=True))[:50]
file = open('sortedPR.txt', 'w')
for spr in sortedPR:
    file.write("%s\n" % str(spr))
file.close()

#Sorts the inlinks and gets top 50
sortedIL = (sorted(inlinks_dict,key=lambda k: len(inlinks_dict[k]), reverse=True))[:50]
file = open('sortedIL.txt','w')
for sil in sortedIL:
    file.write("%s -> %s\n" % (str(sil),str(len(inlinks_dict[sil]))))
file.close()