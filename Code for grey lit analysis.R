library(dplyr)
library(stringr)
library(openxlsx)

df <- pdfs_texts


#BLOCK1 "GREY LITERATURE"

# Add the "IsThereGrey?" column
df <- df %>%
  mutate(IsThereGrey = ifelse(str_detect(text, "grey literature"), "YES", "NO"))

# Function to extract 5 lines before and after "grey literature"
extract_context <- function(text) {
  lines <- str_split(text, "\n")[[1]]
  indices <- which(str_detect(lines, "grey literature"))
  
  if (length(indices) == 0) {
    return(NA_character_)
  }
  
  start_index <- max(1, indices[1] - 2)
  end_index <- min(length(lines), indices[1] + 3)
  
  context_lines <- lines[start_index:end_index]
  
  return(paste(context_lines, collapse = "\n"))
}

# Extract the context and add it to the "SentenceWithGrey" column
df <- df %>%
  mutate(SentenceWithGrey = ifelse(IsThereGrey == "YES", 
                                   sapply(text, extract_context), 
                                   NA_character_))



#BLOCK2 "UNPUBLISHED RESEARCH"
#Add column "IsThereUnpublished"
df <- df %>%
  mutate(IsThereUnpublished = ifelse(str_detect(text, "unpublished literature"), "YES", "NO"))

# Count 'YES' to know if we need to run text extraction
count_yes_unpublished <- sum(df$IsThereUnpublished == "YES", na.rm = TRUE)

cat("Count of 'YES' in IsThereUnpublished:", count_yes_unpublished, "\n") #COUNT IS 23

# Function to extract 5 lines before and after "unpublished literature"
extract_context <- function(text) {
  lines <- str_split(text, "\n")[[1]]
  indices <- which(str_detect(lines, "unpublished literature"))
  
  if (length(indices) == 0) {
    return(NA_character_)
  }
  
  start_index <- max(1, indices[1] - 2)
  end_index <- min(length(lines), indices[1] + 3)
  
  context_lines <- lines[start_index:end_index]
  
  return(paste(context_lines, collapse = "\n"))
}

# Extract the context and add it to the "SentenceWithUnpublished" column
df <- df %>%
  mutate(SentenceWithUnpublished = ifelse(IsThereUnpublished == "YES", 
                                   sapply(text, extract_context), 
                                   NA_character_))




#BLOCK3 "NON-TRADITIONAL PUBLICATION" 

#Add column "IsThereNonTraditional"
df <- df %>%
  mutate(IsThereNonTraditional = ifelse(str_detect(text, "non-traditional publication"), "YES", "NO"))

# Count 'YES' to know if we need to run text extraction
count_yes_unpublished <- sum(df$IsThereNonTraditional == "YES", na.rm = TRUE)

cat("Count of 'YES' in IsThereUnpublished:", count_yes_unpublished, "\n") #COUNT IS 0


#BLOCK4 "NON-TRADITIONAL LITERATURE" -> Deletes original text when done

#Add column "IsThereNonTraditionalLIT"
df <- df %>%
  mutate(IsThereNonTraditionalLIT = ifelse(str_detect(text, "non-traditional literature"), "YES", "NO"))

# Count 'YES' to know if we need to run text extraction
count_yes_unpublished <- sum(df$IsThereNonTraditional == "YES", na.rm = TRUE)

cat("Count of 'YES' in IsThereUnpublished:", count_yes_unpublished, "\n") #COUNT IS 0




#LAST, cleaning text column for lean export
df$text <- ""
write.csv(df, "exports_final.csv")

