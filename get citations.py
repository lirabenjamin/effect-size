from scholarly import scholarly
import time

def get_citations(author_name):
    search_query = scholarly.search_author(author_name)
    author = scholarly.fill(next(search_query))
    
    return author['citedby']

author_name = 'Benjamin Lira'  # replace with your name
#print current date and citations
print(time.strftime("%d/%m/%Y"))
print(get_citations(author_name))

