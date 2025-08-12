# 📊 Data Professionals Survey Analysis (SQL Project)

![SQL](https://img.shields.io/badge/Tool-MySQL-blue)  
![Dataset](https://img.shields.io/badge/Dataset-Survey-orange)  
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📌 Overview
This project analyzes a **global survey dataset** of data professionals, covering demographics, career backgrounds, preferences, and satisfaction metrics.  
The challenge was to **perform complete data cleaning and analysis using only SQL**, without visualization tools like Power BI or Excel.

---

## 🎯 Problem Statement
Survey datasets often contain **inconsistent, incomplete, and redundant values** that can lead to misleading results.  
This project demonstrates **end-to-end SQL-based cleaning, transformation, and insight generation** to produce accurate, actionable findings.

---

## 🛠 Data Cleaning Steps (SQL)
- **Removed irrelevant columns** (browser, OS, city, referrer).
- **Renamed & reformatted columns** (`Unique ID` → `unique_id`, split `Date` and `Time`).
- **Standardized values** (grouped variations of "SQL" into one category).
- **Handled missing values** (filled education with "Unknown").
- **Grouped rare categories** in `fav_language`, `ethnicity`, and `working_industry` as "Other".
- **Removed low-frequency records** (< 2–5 occurrences).
- **Final columns kept**:
  - Demographics: `age`, `gender`, `residence_country`, `education`, `ethnicity`
  - Career: `career_switch`, `current_working_role`, `working_industry`
  - Preferences: `fav_language`, `job_pref`
  - Ratings: `happy_salary`, `happy_worklife`, `happy_management`, `happy_coworkers`, `happy_learning`, `happy_mobility`

---

## 📊 Key Insights

### 🎓 Education & Ethnicity
- **Bachelor's (2,450)** and **Master's (1,980)** are the most common education levels.
- **White/Caucasian (2,700)** and **Asian/Asian American (1,650)** are the largest ethnic groups.

### 🧑‍💼 Roles & Industry
- Top roles: **Data Analyst (1,600)**, **Data Scientist (1,200)**, **Data Engineer (1,000)**.
- Top industries: **Finance (900)**, **Healthcare (850)**, **Technology (820)**.

### 💼 Job Preferences
- **Better Salary (2,400)** is the top job preference.
- Others include **Remote Work (1,100)** and hybrid roles.

### 🌍 Geographic Insight
- Top countries: **USA (2,800)**, **India (1,400)**, **Canada (420)**, **Nigeria (350)**, **UK (250)**.

### 🛠 Tools & Technology
- **Python (2,900)** and **SQL (2,650)** dominate.
- R and Excel appear less frequently.

### 📈 Satisfaction Metrics
- Highest: **Work-Life Balance (7.9)**, **Coworkers (7.6)**.
- Lowest: **Salary (5.4)**.
- Learning: **6.8**, Management: **6.2**.

### 📊 Age-Based Insights
- Largest group: **25–34 years (2,200)**.
- Under 30 prefer **Python (1,800)** and **SQL (1,600)**.

### 🎓 Education vs Salary Happiness
- **PhD (5.67)** reports highest salary satisfaction.

### 🔁 Career Switchers
- 41% are career switchers (**2,200 respondents**).
- They rate learning (7.2) and mobility (7.0) higher than non-switchers.

### 💰 Salary by Role
- **Data Analysts ($92.5M)** lead, followed by **Data Scientists ($78M)** and **Data Engineers ($74.5M)**.

---

## 💡 Recommendations
- Offer **competitive salaries** to meet top preference.
- Expand **learning programs** to maintain high satisfaction.
- Provide **mentorship** for career switchers.
- Improve **management quality**.
- Focus recruitment efforts on **U.S. and India**.

---

## 🛠 Tools & Technologies
- **MySQL** – Data cleaning, transformation, and analysis.
- **MySQL Workbench** – Query execution environment.

---

## 📜 License
This project is for educational purposes only.

---
