# Credit Risk Scorecard Dashboard
**SQL · Power BI**

---

## The Problem

Lending is fundamentally a bet on repayment. When borrowers default, lenders absorb the
loss - and at portfolio scale, even small shifts in default rates carry significant financial
consequences. Credit teams need to know three things:

- Who is likely to default?
- Where is risk concentrated right now?
- Has the portfolio been getting riskier or safer over time?

This project builds a dashboard that answers all three, using Lending Club loan data
covering 2.2M+ loans from 2007 to 2018.

---

## The Dashboard

### Page 1 - Executive Summary
The top-line view includes total loans, total defaults, average default rate, and average interest rates.
A bar chart breaks default rates down by loan grade - Grade G borrowers default at 35%,
compared to 3% for Grade A. A donut chart shows loan purpose distribution, with debt
consolidation making up 59% of the book.

### Page 2 - Risk Segmentation
A heatmap matrix crosses loan grade against DTI (Debt to Income ratio) bucket - 
the Grade G / High DTI cell sits at 36.91%, the riskiest combination in the portfolio. 
A scatter plot shows how interest rates track borrower quality across grades, 
and a stacked bar breaks default volume down by income band. 
Three slicers let you filter everything by grade, DTI, and income.

### Page 3 - Vintage Analysis
A longitudinal look at how different loan cohorts have performed year over year. The 2007–2009
vintages show the sharpest spike in defaults - consistent with the financial crisis. Default
rates declined steadily post-2015, reflecting tighter underwriting standards after the
crisis. The 2018 drop is expected: those loans haven't had enough time to default yet
(vintage immaturity).

---

## Data Pipeline

The raw CSV goes through a 3-layer SQL pipeline before it reaches Power BI:

```
raw_loans  →  staging_loans  →  mart_default_by_segment
                             →  mart_vintage
```

The staging layer is where most of the work happens - cleaning nulls, engineering six
risk features, and flagging defaults from raw loan status strings.

| Feature | Logic |
|---|---|
| `is_default` | 1 if loan status is Charged Off or Default |
| `dti_bucket` | DTI grouped into Low / Medium / High / Very High |
| `income_band` | Annual income grouped into <40K / 40K–80K / 80K–120K / 120K+ |
| `has_delinquency` | 1 if any delinquency in past 2 years |
| `term_months` | Term parsed from string to integer |

---

## What the Data Shows

- Average default rate across the portfolio is **18.45%**
- Grade G borrowers default at **12× the rate** of Grade A borrowers
- The riskiest segment is Grade G borrowers with high DTI - **36.91% default rate**
- The **40K–80K income band** holds the most loans and the most defaults in absolute terms
- Pre-crisis 2007 vintages peak at ~48% default rate for Grade F and G loans

---

## Tools

| | |
|---|---|
| SQLite + DB Browser | Querying and mart table creation |
| Power BI Desktop | Data model, DAX measures, dashboard |
| Power Query | Type validation and column transforms |

---

## Data Source

Lending Club Loan Data via [Kaggle](https://www.kaggle.com/datasets/wordsforthewise/lending-club).
~2.2M records, 2007–2018. Raw CSV not included - download and place in `/data` before
running SQL scripts.

---

## Repo Structure

```
credit-risk-scorecard/
├── README.md
├── sql/
│   ├── 01_raw_loans.sql
│   ├── 02_staging_loans.sql
│   ├── 03_mart_default_by_segment.sql
│   └── 04_mart_vintage.sql
├── data/
│   └── data_source.md
├── screenshots/
│   ├── page1_executive_summary.png
│   ├── page2_risk_segmentation.png
│   └── page3_vintage_analysis.png
└── dashboard/
    └── CreditRiskScorecard.pbix
```

---

*Angela-Frances Ibhade · MSc Statistics, Brock University (2026)*
