import os
import hashlib
import pandas as pd

source_file = "data/source/Superstore.csv"
destination_file = "data/destination/Superstore.csv"

# Check if both files exist
if not os.path.exists(source_file):
    print(" Source file not found!")
    exit()

if not os.path.exists(destination_file):
    print(" Destination file not found!")
    exit()

# Read CSV files
source_df = pd.read_csv(source_file, encoding="latin1")
destination_df = pd.read_csv(destination_file, encoding="latin1")

# Row and column counts
print("=" * 50)
print("VALIDATION ACTIVITY")
print("=" * 50)

print(f"Source Rows       : {len(source_df)}")
print(f"Destination Rows  : {len(destination_df)}")
print(f"Source Columns    : {len(source_df.columns)}")
print(f"Destination Columns: {len(destination_df.columns)}")

# Compare content
if source_df.equals(destination_df):
    print("\n Data Validation Successful!")
else:
    print("\n Data Validation Failed!")

# Optional: Compare file hashes
def file_hash(path):
    with open(path, "rb") as f:
        return hashlib.md5(f.read()).hexdigest()

print("\nMD5 Hash Comparison")
print(f"Source      : {file_hash(source_file)}")
print(f"Destination : {file_hash(destination_file)}")

if file_hash(source_file) == file_hash(destination_file):
    print("\n File Integrity Verified!")
else:
    print("\n File Integrity Check Failed!")