#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: Missing folder name argument."
  echo "Usage: $0 <folder_name>"
  exit 1
fi

folder_name="$1"

# Create the folder with the provided name
mkdir -p "./content/$folder_name"

# today's date
today_date=$(date +"%Y-%m-%d")

# Define the content for the index.md file
index_md_content=$(cat <<EOF
---
title:  
summary: 
date: $today_date
math: true
featured: false
authors: 
 - admin
tags: 
categories: 
---
EOF
)

# Create the index.md file and write the content
echo "$index_md_content" > "./content/$folder_name/index.md"

echo "Folder '$folder_name' with index.md created successfully."
