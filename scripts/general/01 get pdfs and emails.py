import pandas as pd
import requests
from tqdm import tqdm
import PyPDF2
import re
import os
import string as str

# Read the CSV into a pandas dataframe
df = pd.read_csv("data/psych_meta_18_23.csv", encoding="latin1")

df.columns
df.ArticleURL[0]

# Filter and select relevant columns
df = df[["Authors", "Title", "Year", "FullTextURL"]]
df["Title"] = df["Title"].str.replace("\\/", "-")
df.dropna(subset=["FullTextURL"], inplace=True)
df["filename"] = "data/downloads/" + df["Year"].astype(str) + "_" + df["Title"] + ".pdf"

# Initialize new columns
df["downloaded"] = False
df["error"] = False

def download_file(url, filename):
    try:
        if not os.path.exists(filename):  # Check if the file already exists
            response = requests.get(url)
            response.raise_for_status()  # Raise an error for bad responses
            with open(filename, 'wb') as file:
                file.write(response.content)
            return True
    except requests.RequestException:
        return False

def extract_emails_from_pdf(pdf_path):
    emails = []
    try:
        with open(pdf_path, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            for page_num in range(len(reader.pages)):
                text = reader.pages[page_num].extract_text()
                emails += re.findall(r"[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+", text)
        return emails, False
    except PyPDF2.errors.PdfReadError:
        return [], True

# Progress bar with tqdm
for _, row in tqdm(df.iterrows(), total=df.shape[0]):
    download_status = download_file(row["FullTextURL"], row["filename"])
    if download_status:
        df.at[_, "downloaded"] = True
        emails, error = extract_emails_from_pdf(row["filename"])
        df.at[_, "emails"] = ", ".join(emails)
        df.at[_, "error"] = error
    else:
        df.at[_, "error"] = True
        
# Save the updated dataframe to a new CSV
df.to_csv("data/updated_psych_meta_18_23.csv", index=False)

df = pd.read_csv("updated_psych_meta_18_23.csv")
df.value_counts("downloaded")
df.emails.isna().value_counts()