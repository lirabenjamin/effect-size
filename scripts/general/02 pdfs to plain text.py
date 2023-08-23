import PyPDF2
import re
import os

def extract_emails_from_pdf(pdf_path):
    """Extracts emails from a given PDF file."""
    emails = []
    
    with open(pdf_path, 'rb') as file:
        reader = PyPDF2.PdfReader(file)
        
        for page_num in range(len(reader.pages)):
            text = reader.pages[page_num].extract_text()
            emails += re.findall(r"[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+", text)
    
    return emails

extract_emails_from_pdf("test.pdf")

def extract_emails_from_folder(folder_path):
    """Extracts emails from all PDFs in a given folder."""
    all_emails = []
    
    for filename in os.listdir(folder_path):
        if filename.endswith(".pdf"):
            pdf_path = os.path.join(folder_path, filename)
            emails = extract_emails_from_pdf(pdf_path)
            all_emails.extend(emails)
    
    return all_emails

folder_path = "."  # Replace this with the path to your folder
emails = extract_emails_from_folder(folder_path)
print(emails)
