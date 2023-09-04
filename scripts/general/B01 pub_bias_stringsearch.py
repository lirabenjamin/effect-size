import PyPDF2
import pandas as pd
from tqdm import tqdm
import concurrent.futures
import os

publication_bias = ['publication bias']
unpublished = ['unpublished', 'unpublished data', 'unpublished studies', 'unpublished study']
gray_literature = ['gray literature', 'grey literature', "theses", "thesis","conference",'working paper']
method_funnel = ['funnel plot']
method_trim_and_fill = ['trim and fill']
method_egger = ['egger']
method_fail_safe_N = ['fail safe n', 'fail-safe n' , 'file drawer number']
method_pet_peese = ['pet-peese', 'petpeese', 'pet peese', 'precision-effect', 'precision effect']
method_robma = ['robust bayesian meta-analysis', "robust bayesian meta-analysis","robma"]


terms = [publication_bias, unpublished, method_funnel, method_trim_and_fill, method_egger, method_fail_safe_N, method_pet_peese, method_robma]

# create a function that will read a pdf file and return 1 if it matches, and 0 if not. Do for each of hte above lists
def search_pdf(pdf_file, terms_list):
    """Search a PDF for a list of terms and return a list of 1s or 0s for each term group."""
    results = []
    
    try:
      with open(pdf_file, 'rb') as f:
          reader = PyPDF2.PdfReader(f)
          text = ""
          for page_num in range(len(reader.pages)):
              text += reader.pages[page_num].extract_text().lower()

          for terms in terms_list:
              found = any(term in text for term in terms)
              results.append(1 if found else 0)
    except PyPDF2.errors.PdfReadError:
        print(f"Error reading {pdf_file}: EOF marker not found")
        # if there's an error reading the PDF, we can assume that none of the terms are found in it
        results = [99 for _ in terms_list]
        
    except Exception as e:
        print(f"Error reading {pdf_file}: {e}")
        results = [99 for _ in terms_list]
      
    return results

folder = 'data/downloads'

def process_file(pdf_file):
    """Wrapper function to apply search_pdf for each file."""
    return (pdf_file, search_pdf(pdf_file, terms))

# Get list of all PDF files in the folder
pdf_files = [os.path.join(folder, f) for f in os.listdir(folder) if f.endswith('.pdf')]

# Run search_pdf in parallel for all PDF files
with concurrent.futures.ThreadPoolExecutor() as executor:
    results = list(tqdm(executor.map(process_file, pdf_files), total=len(pdf_files)))
    
results

# Convert results to a dataframe
df = pd.DataFrame(results, columns=['file', 'results'])

# Split results into separate columns
df[['publication_bias', 'unpublished', 'method_funnel', 'method_trim_and_fill', 'method_egger', 'method_fail_safe_N', "begg"]] = pd.DataFrame(df['results'].tolist(), index=df.index)


df['mean'] = df[['publication_bias', 'unpublished', 'method_funnel', 'method_trim_and_fill', 'method_egger', 'method_fail_safe_N', "begg"]].mean(axis=1)

df = df[df['mean'] != 99]

import seaborn as sns
import matplotlib.pyplot as plt

# Plot the proportion of papers that mention each term
sns.set_style("whitegrid")
ax = sns.barplot(data=df[['publication_bias', 'unpublished', 'method_funnel', 'method_trim_and_fill', 'method_egger', 'method_fail_safe_N', "begg"]].mean(axis=0).reset_index().rename(columns={'index': 'term', 0: 'proportion'}), x='term', y='proportion')
ax.set_xticklabels(ax.get_xticklabels(), rotation=45, horizontalalignment='right')
plt.show()
