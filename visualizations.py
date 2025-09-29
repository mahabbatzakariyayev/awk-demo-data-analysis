import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("grades.csv")
df.columns = df.columns.str.replace('"', '').str.strip()
df = df.applymap(lambda x: str(x).replace('"', '') if isinstance(x, str) else x)
numeric_cols = ["Test1", "Test2", "Test3", "Test4", "Final"]
df[numeric_cols] = df[numeric_cols].apply(pd.to_numeric, errors="coerce")
print("Dataset shape:", df.shape)
print(df.head())
plt.figure(figsize=(6, 4))
sns.countplot(x="Grade", data=df, order=df["Grade"].value_counts().index, palette="viridis")
plt.title("Grade Distribution")
plt.xlabel("Grade")
plt.ylabel("Count")
plt.show()
avg_scores = df[numeric_cols].mean()
plt.figure(figsize=(6, 4))
avg_scores.plot(kind="bar", color="skyblue")
plt.title("Average Score by Test")
plt.ylabel("Average Score")
plt.show()
plt.figure(figsize=(10, 6))
sns.heatmap(df[numeric_cols].iloc[:20], annot=True, cmap="YlGnBu", cbar=True)
plt.title("Sample of Student Test Scores (first 20)")
plt.xlabel("Tests")
plt.ylabel("Student Index")
plt.show()
plt.figure(figsize=(8, 5))
sns.boxplot(data=df[numeric_cols], palette="Set2")
plt.title("Score Distribution with Outliers")
plt.show()
def letter(avg):
    if avg >= 90: return "A"
    elif avg >= 80: return "B"
    elif avg >= 70: return "C"
    elif avg >= 60: return "D"
    else: return "F"
df["AvgScore"] = df[numeric_cols].mean(axis=1)
df["ExpectedGrade"] = df["AvgScore"].apply(letter)
mismatches = df[df["ExpectedGrade"].str[0] != df["Grade"].str[0]]
print("\nStudents with incorrect or inconsistent grades:")
print(mismatches[["First name", "Last name", "AvgScore", "ExpectedGrade", "Grade"]])
