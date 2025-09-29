# awk-demo-data-analysis

This project demonstrates **data analysis using Bash and AWK** on a sample student grades dataset. It provides a collection of AWK one-liners and scripts to explore, clean, and summarize CSV-formatted data without relying on external libraries.

## Project Structure

* **`code2.sh`** – Bash script containing AWK commands for various grade-related analyses.
* **`grades.csv`** – Sample dataset of student test scores and final grades.
* **`README.md`** – Documentation for the project.

## Features

The script includes AWK-based operations such as:

* Displaying the first few lines of the dataset.
* Printing student first and last names.
* Counting the number of fields (columns).
* Removing outliers (null values or negative scores).
* Listing names with grades.
* Counting total records.
* Filtering students by grade or test score conditions.
* Computing test score **sum, average, min, max**.
* Calculating each student’s average and comparing with reported letter grade.
* Generating **grade distribution** with percentages.
* Counting **high performers** (e.g., Test1 ≥ 80).
* Producing a **class statistics summary**.
* Detecting **incorrect or inconsistent grades** (expected vs. reported).

## Getting Started

### Prerequisites

* Unix-like shell environment (Linux, macOS, WSL, etc.)
* `awk` installed (usually pre-installed)
* `curl` (optional, for fetching datasets)

### Run the Script

1. Ensure the dataset `grades.csv` is present in the project directory.
   *(You can also uncomment the `curl` lines in `code2.sh` to automatically download a dataset.)*

2. Make the script executable:

```bash
chmod +x code2.sh
```

3. Run the script:

```bash
./code2.sh
```

### Example Output

```
Print first 3 lines:
"Last name","First name","SSN","Test1","Test2","Test3","Test4","Final","Grade"
"Alfalfa","Aloysius","123-45-6789","40","90","100","83","49","D-"
"Alfred","University","123-12-1234","41","97","96","97","48","D+"
```

(Full results include averages, grade distributions, and error checks.)

## Use Cases

* Learn **text processing** with AWK.

* Perform **quick exploratory data analysis** in Bash.
* Validate datasets by identifying **inconsistencies** in grading.
* Practice **shell scripting** for automation.

## License

This project is open-source and available under the MIT License.
 

python3 -m pip install matplotlib seaborn
python3 visualizations.py