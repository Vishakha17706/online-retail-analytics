## My Project Contribution — Vishakha Sirwani

This project is adapted from [ndkn-code/online-retail-analytics](https://github.com/ndkn-code/online-retail-analytics). Credit for the original code and project structure belongs to the original author.

### Project Overview
Retail transaction analysis using SQL, Python and Tableau to explore sales trends, returns, customer segments, retention and revenue concentration.

Dataset: UCI Online Retail II, covering December 2009 to December 2011.

### My Contributions
- Ran the Python data cleaning and analysis pipeline.
- Executed all five SQL analysis files using SQLite through Python.
- Resolved inconsistent segmentation results by updating Python to reuse the SQL scoring logic.
- Verified that segmentation results matched across SQL, Python and dashboard exports.
- Built and published a Tableau dashboard containing seven charts.

### Live Dashboard
[View E-Commerce Customer & Revenue Analytics](https://public.tableau.com/app/profile/vishakha.sirwani/viz/E-CommerceCustomerRevenueAnalytics_/RetailAnalyticsDashboard)

### Dashboard Preview
![Retail Analytics Dashboard](dashboards/dashboard_preview.png)

### Tools Used
- SQL / SQLite: aggregation, CTEs, joins and window functions.
- Python: pandas, Matplotlib and sqlite3.
- Tableau Public: charts and dashboard.
- GitHub: project documentation and version history.

### Verified Findings
- Raw dataset: 1,067,371 transaction rows.
- Cleaned sales dataset: 1,003,340 transaction lines.
- Total sales revenue before returns: £19,643,861.62.
- Identified customers: 5,852.
- United Kingdom: 85.53% of total sales revenue.
- Return value: £716,425.97, equivalent to 3.65% of sales revenue.
- Champions: 1,460 customers, representing 24.9% of identified customers and 68.8% of identified-customer sales revenue.
- Top 100 customers: 37.6% of identified-customer sales revenue.
- December 2009 cohort: 333 of 951 customers purchased again in January 2010, a 35.0% monthly repeat-purchase rate.

### Business Recommendations
- Prioritize retention efforts for high-value customer segments.
- Investigate unusually large cancellations before drawing conclusions about product quality.
- Monitor dependence on the UK market and high-spending customers.

These are recommendations based on analysis, not measured business improvements.

### Limitations
- December 2011 includes transactions only through December 9; it is not comparable to a complete month.
- 22.6% of cleaned sales lines have no customer ID. They are included in total sales revenue but excluded from customer analysis.
- Sales revenue excludes cancellations; returns are analyzed separately.
- Cohorts use the first purchase observed in this dataset, which may not be a customer's first-ever purchase.
- Customer segments describe behaviour at the historical dataset snapshot, not current customer activity.

---

# E-Commerce Customer & Revenue Analytics

A SQL + Python + Tableau study of **real UK online-retail transactions**: *where does
revenue concentrate, how much leaks back out as returns, and which customers should the
business protect, grow, or win back?*

> ✅ **Real, public data, not synthetic.** This project runs on the **UCI Online Retail II**
> dataset: ~**1.07 million actual transactions** from a UK-based online gift retailer,
> 01 Dec 2009 – 09 Dec 2011. Every figure below is **publicly verifiable and fully
> reproducible**, `data/fetch_data.py` downloads the file straight from the UCI ML
> Repository, `data/clean_data.py` runs the documented cleaning pipeline, and
> `notebook/analysis.py` reproduces every number and chart. No data is fabricated; the
> value here is provenance, reproducibility, and an honest cleaning of genuinely messy data.
>
> **Citation:** Chen, D. (2019). *Online Retail II* [Dataset]. UCI Machine Learning
> Repository. <https://doi.org/10.24432/C5CG6D> ·
> page: <https://archive.ics.uci.edu/dataset/502/online+retail+ii>

**Stack:** SQL (SQLite; CTEs, window functions, `NTILE` for RFM) · Python (pandas, matplotlib) · Tableau Public

---

## The business questions
1. **Revenue**: when, where, and on what products does revenue happen? (trend, country mix, top SKUs)
2. **Returns**: how much revenue leaks back out as cancellations, by value and by volume?
3. **Customers**: who are the high-value segments (RFM), do cohorts retain, and how concentrated is revenue?

## Data cleaning (step 0, the real selling point)
Real transactional data is messy. The raw file is two Excel sheets totalling **1,067,371 rows**;
[`data/clean_data.py`](data/clean_data.py) turns it into a trustworthy sales grain and prints a
full before→after waterfall. What gets removed, and why:

| Step | Rule | Rows removed | Rows remaining |
|------|------|-------------:|---------------:|
| raw (both sheets) | - | - | **1,067,371** |
| drop exact duplicates | identical rows across all 8 fields | −34,335 | 1,033,036 |
| split off cancellations | `Invoice` starts `C` → moved to a **returns** file, analysed separately | −19,104 | 1,013,932 |
| drop non-product codes | service codes: `POST`, `DOT`, `M`, `BANK CHARGES`, `AMAZONFEE`, `ADJUST`, gift-card codes, `TEST*`… | −4,630 | 1,009,302 |
| drop `Quantity ≤ 0` | non-positive quantity in the sales grain | −3,391 | 1,005,911 |
| drop `Price ≤ 0` | free/adjustment lines, not genuine sales | −2,571 | **1,003,340** |

Plus: **226,761 rows (22.6%) have no `Customer ID`** (guest/unidentified), kept in revenue totals
but **excluded from all customer-level analysis** (RFM, cohort, Pareto). The 17,914 cancellation lines
are kept in `online_retail_returns.csv` for the returns analysis. `revenue = quantity × price` (GBP).

## Key findings *(actual computed figures from the real data)*

**Revenue is concentrated and seasonal**
- **£19.64M total revenue (GBP)** across **39,516 invoices** and **5,852 identified customers** in **43 countries**.
- The **UK is 85.5% of revenue (£16.8M)**; the next markets are EIRE (3.2%), Netherlands (2.8%), Germany (2.0%), France (1.6%).
- Revenue **peaks every November** (£1.43M Nov-2010, £1.45M Nov-2011) on the pre-Christmas run-up, roughly double a quiet spring month. Top SKU: *Regency Cakestand 3 Tier* (£330K).

**A small core of customers carries the business** *(RFM segmentation)*
- **Champions: 24.9% of customers but 68.8% of revenue.** With **Loyal Customers (20.6% / 14.2%)**, two segments hold ~83% of revenue.
- **At Risk** customers are 14.1% of customers but **9.3% of revenue**, high-value and slipping away (a win-back target).
- Pareto confirms it: **top 10 customers = 16.1%**, **top 100 = 37.6%** of identified-customer revenue; **~23% of customers generate 80% of revenue**.

**Retention is a first-month problem**
- **Average month-1 repeat-purchase rate ≈ 21%** across cohorts: most buyers don't return the next month.
- But a loyal core persists: the Dec-2009 cohort is still **~38% active 12 months later**, and **72% of identified customers place 2+ orders** over their lifetime.

**Returns are a modest, fixable leak**
- Cancellations run **3.65% of revenue (£716K)** and **4.18% of units**, healthy overall, concentrated in a few high-value SKUs.

## Recommendations
1. **Build a retention/VIP programme around Champions + Loyal Customers**: ~46% of customers, ~83% of revenue; defending them is cheaper than re-acquiring their value.
2. **Launch a structured win-back for At Risk customers**: 9.3% of revenue in proven buyers who've gone quiet.
3. **Fix the first-month retention drop**: month-1 repeat is ~21% but lifetime repeat is ~72%; invest in second-purchase triggers and onboarding.
4. **Plan around the November peak and audit return-heavy SKUs** to capture seasonal demand and recover part of the £716K return leak.

*(One-page write-up with the full reasoning: [`reports/insight_memo.md`](reports/insight_memo.md).)*

---

## Dataset at a glance *(after cleaning)*
| | |
|---|---|
| Source | **UCI Online Retail II** (Chen, 2019), real, public |
| Raw rows (two sheets) | **1,067,371** |
| Clean sales lines | **1,003,340** |
| Cancellation/return lines | **17,914** (analysed separately) |
| Total revenue | **£19,643,861.62** (GBP) |
| Unique invoices / customers | **39,516 / 5,852** |
| Unique products / countries | **4,894 / 43** |
| Date range | **2009-12-01 → 2011-12-09** |
| Rows with no Customer ID | **226,761 (22.6%)**, excluded from customer analysis |

## Repo structure
```
data/        fetch_data.py (download from UCI), clean_data.py (cleaning pipeline),
             schema.sql -> data/online_retail.db   (raw .xlsx + .db are git-ignored)
sql/         5 analysis queries (revenue, returns, RFM, cohort, Pareto), CTEs / window functions / NTILE quintiles
notebook/    analysis.ipynb / analysis.py + figures/*.png
dashboards/  Tableau build guide + export_extracts.py + extracts/*.csv
reports/     insight_memo.md
```

## The SQL (what each query answers)
| File | Business question | Techniques |
|------|-------------------|------------|
| `01_revenue_trends.sql` | revenue by month / country / top products | `LAG` (MoM growth), `RANK`, share via `SUM OVER ()` |
| `02_returns_analysis.sql` | return rate by value and by volume | sales↔returns join, monthly trend |
| `03_rfm_segmentation.sql` | Recency/Frequency/Monetary → named segments | **`NTILE(5)` quintiles**, `CASE` segment grid |
| `04_cohort_retention.sql` | repeat-purchase retention by first-order month | CTEs, month-offset math, cohort pivot |
| `05_revenue_concentration.sql` | customer & product Pareto | `ROW_NUMBER`, running `SUM OVER` + running % |

## Charts
`notebook/figures/`: `data_cleaning.png`, `revenue_trend.png`, `top_products_and_country.png`,
`returns.png`, `rfm_segments.png`, `cohort_retention.png`, `pareto.png`.

## Reproduce
```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
python data/fetch_data.py             # -> data/online_retail_II.xlsx  (downloads from UCI, ~45 MB, git-ignored)
python data/clean_data.py             # -> data/online_retail_clean.csv + online_retail.db (prints cleaning waterfall)
python notebook/analysis.py           # -> notebook/figures/*.png
python dashboards/export_extracts.py  # -> dashboards/extracts/*.csv
# run any query:  sqlite3 data/online_retail.db < sql/03_rfm_segmentation.sql
```

## Dashboard
- **Tableau Public, Customer & Revenue Analytics:** _link after publishing_ (build steps: [`dashboards/TABLEAU_GUIDE.md`](dashboards/TABLEAU_GUIDE.md)). _TODO: paste published URL._

---
*Part of [my portfolio](https://jknguyen-portfolio.vercel.app), case study: `/projects/online-retail`.*
