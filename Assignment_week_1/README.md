# Basic Data Exploration and Cleaning using Pandas

## Objective

The objective of this assignment is to perform basic data exploration and cleaning on a shopping dataset using the Pandas library in Python. The tasks include loading data, exploring its structure, handling missing values, removing duplicates, filtering records, creating derived columns, and saving the cleaned dataset.

---

## Dataset Description

The dataset contains product-related information such as:

- Product ID
- Product Title
- Product Description
- Rating
- Ratings Count
- Initial Price
- Discount
- Final Price
- Currency
- Category
- Seller Information
- Product Specifications
- Delivery Options
- And other product attributes

---

## Tools and Libraries Used

- Python
- Pandas
- NumPy
- Jupyter Notebook

---

## Tasks Performed

### 1. Data Loading
- Loaded the dataset using `pd.read_csv()`.

### 2. Data Exploration
Performed basic exploration using:
- `head()`
- `tail()`
- `shape`
- `columns`
- `dtypes`
- `info()`

### 3. Missing Value Handling
- Identified missing values using `isnull().sum()`.
- Filled missing categorical values with `"Unknown"`.
- Filled missing numerical values using the median of the respective column.

### 4. Duplicate Record Removal
- Checked duplicate rows using `duplicated()`.
- Removed duplicates using `drop_duplicates()`.

### 5. Column Selection
Selected important columns such as:
- `title`
- `category`

### 6. Data Filtering
Filtered products with ratings greater than 4.

Example:

```python
filtered_df = df[df["rating"] > 4]
```

### 7. Derived Column Creation

As required in the assignment, a new column was created:

```python
df["quantity"] = 1
df["total_amount"] = df["initial_price"] * df["quantity"]
```

Additional derived column:

```python
df["discount_amount"] = (
    df["initial_price"] * df["discount"] / 100
)
```

### 8. Export Cleaned Dataset

The cleaned dataset was saved as:

```python
df.to_csv("cleaned_dataset.csv", index=False)
```

---

## Output Files

```text
├── Basic_Data_Exploration_Cleaning.ipynb
├── cleaned_dataset.csv
└── README.md
```
---

## Dataset Summary

| Description | Value |
|------------|--------|
| Dataset Type | Shopping Dataset |
| Original Columns | 24 |
| Added Columns | quantity, total_amount, discount_amount |
| Final Output | cleaned_dataset.csv |

---

## Key Learning Outcomes

- Data loading using Pandas
- Dataset exploration techniques
- Handling missing values
- Removing duplicate records
- Filtering data using conditions
- Creating derived columns
- Exporting cleaned datasets

---

## Conclusion

The dataset was successfully explored and cleaned using Pandas. Missing values and duplicate records were handled appropriately, relevant columns were selected, rows were filtered based on ratings, and derived columns (`total_amount` and `discount_amount`) were created. Finally, the cleaned dataset was exported as a CSV file for further analysis.