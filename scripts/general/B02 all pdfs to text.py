from tqdm import tqdm
import os
import pandas as pd
import PyPDF2
import string as str

def extract_text_from_pdf(pdf_path):
    """Extract text from a PDF and return as a string."""
    text = ""
    try:
        with open(pdf_path, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            for page_num in range(len(reader.pages)):
                text += reader.pages[page_num].extract_text()
    except Exception as e:
        print(f"Error reading {pdf_path}: {e}")
    return text

# Path to the folder containing PDF files
folder = 'data/downloads'

# Get list of all PDF files in the folder
pdf_files = [os.path.join(folder, f) for f in os.listdir(folder) if f.endswith('.pdf')]

# Extract text from each PDF and store in a list of dictionaries
data = []
for pdf_file in tqdm(pdf_files):
    text = extract_text_from_pdf(pdf_file)
    data.append({'file_name': os.path.basename(pdf_file), 'text': text})

# Convert the list of dictionaries into a pandas DataFrame
df = pd.DataFrame(data)

# Optionally, save the DataFrame to a CSV
df = df.astype("str")
df['text'] = df['text'].str.encode('utf-8', 'surrogatepass').str.decode('utf-8', 'replace')

df.to_parquet('data/pdf_texts.parquet', index=False)

# Read parquet
df = pd.read_parquet('data/pdf_texts.parquet')

# convert text to lowercase
df['text'] = df['text'].str.lower()

def contains_any_terms(df, column_name, terms):
    mask = False  # Initialize a mask to False for all rows
    for term in terms:
        mask |= df[column_name].str.contains(term, case=False, na=False)
    return mask
  
publication_bias = ['publication bias']
unpublished = ['unpublished', 'unpublished data', 'unpublished studies', 'unpublished study']
gray_literature = ['gray literature', 'grey literature', "theses", "thesis","conference",'working paper']
method_funnel = ['funnel plot']
method_trim_and_fill = ['trim and fill']
method_egger = ['egger']
method_fail_safe_N = ['fail safe n', 'fail-safe n' , 'file drawer number']
method_pet_peese = ['pet-peese', 'petpeese', 'pet peese', 'precision-effect', 'precision effect']
method_robma = ['robust bayesian meta-analysis', "robust bayesian meta-analysis","robma"]

df = df[df['text'] != ""]

df['publication bias'] = contains_any_terms(df, 'text', publication_bias)
df['unpublished_data'] = contains_any_terms(df, 'text', unpublished)
df['gray_literature'] = contains_any_terms(df, 'text', gray_literature)
df['funnel plot'] = contains_any_terms(df, 'text', method_funnel)
df['trim and fill'] = contains_any_terms(df, 'text', method_trim_and_fill)
df['egger'] = contains_any_terms(df, 'text', method_egger)
df['fail safe n'] = contains_any_terms(df, 'text', method_fail_safe_N)
df['pet-peese'] = contains_any_terms(df, 'text', method_pet_peese)
df['robma'] = contains_any_terms(df, 'text', method_robma)

# plot proportions across time
df['year'] = df['file_name'].str.extract(r'(\d{4})')
df['year'] = df['year'].astype('float')

# drop raw text
df = df.drop(columns=['text'])

# export to csv
df.to_csv('data/string_counts.csv', index=False)