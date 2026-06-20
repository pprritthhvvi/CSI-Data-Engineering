# Basic Data Exploration and Cleaning using Pandas

## Objective

The objective of this assignment is to learn Python basics and perform data exploration and data cleaning using the Pandas library. The dataset used is a shopping dataset containing product-related information.

---

## Dataset

**File Used:** `Combined_dataset.csv`

The dataset contains product information such as category, prices, ratings, seller details, reviews, and other shopping-related attributes.

---

## Tools and Libraries Used

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* Jupyter Notebook

---

## Steps Performed

### Step 1: Load the Dataset

* Imported the required libraries.
* Loaded the CSV file into a Pandas DataFrame.

### Step 2: Explore the Dataset

* Displayed the first 5 rows using `head()`.
* Displayed the last 5 rows using `tail()`.
* Checked dataset shape.
* Viewed column names.
* Checked data types using `dtypes`.
* Generated dataset information using `info()`.
* Generated statistical summary using `describe()`.

### Step 3: Handle Missing Values

* Identified missing values using `isnull().sum()`.
* Filled numerical missing values with the mean value.
* Filled categorical missing values with the mode value.

### Step 4: Perform Basic Operations

* Selected specific columns from the dataset.
* Filtered rows based on conditions.

### Step 5: Remove Duplicate Records

* Checked the number of duplicate rows.
* Removed duplicate records using `drop_duplicates()`.

### Step 6: Data Visualization

* Created a bar chart showing the top product categories in the dataset.
* Visualized category distribution using Matplotlib.

### Step 7: Save the Cleaned Dataset

* Saved the cleaned dataset as:

`cleaned_shopping_dataset.csv`

---

## Output Files

1. `Basic_Data_Exploration_and_Cleaning.ipynb`
2. `cleaned_shopping_dataset.csv`
3. `README.md`

---

## Conclusion

This assignment helped in understanding basic data exploration and data cleaning techniques using Pandas. Missing values were handled, duplicate records were removed, basic filtering operations were performed, and the cleaned dataset was successfully saved for further analysis.
