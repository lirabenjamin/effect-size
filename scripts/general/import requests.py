import requests
from bs4 import BeautifulSoup

def search_pubmed(query, mindate, maxdate):
    base_url = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?'
    params = {
        'db': 'pubmed',
        'term': query,
        'mindate': mindate,
        'maxdate': maxdate,
        'datetype': 'pdat',
        'usehistory': 'y',
        'retmode': 'xml',
        'retmax': 500
    }
    response = requests.get(base_url, params=params)
    soup = BeautifulSoup(response.content, 'xml')
    return [id.text for id in soup.find_all('Id')]

ids = search_pubmed('(meta-analysis[Title]) AND (psychology[Journal])', '2018/01/01', '2023/12/31')

len(ids)
