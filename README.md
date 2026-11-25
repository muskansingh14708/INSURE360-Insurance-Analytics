# INSURE360 — Insurance Intelligence & Persistency Analytics

An end-to-end insurance analytics project exploring policy persistency, lapse behaviour, premium exposure, payment patterns and hypothetical retention opportunities using SQL, Excel and Power BI.

INSURE360 transforms synthetic insurance data into analytical insights to support portfolio monitoring, lapse-risk assessment and retention decision-making.

## Business Problem

Insurance companies need to monitor policy persistency, payment behaviour and portfolio exposure to understand where policies are being discontinued and where retention opportunities may exist.

A portfolio-level view alone may not reveal patterns across policy products, distribution channels, customer locations or policy tenure.

INSURE360 explores these patterns using insurance policy and payment data to examine:

- How the portfolio is distributed across policy statuses.
- How lapse patterns vary across products and distribution channels.
- How policy tenure relates to the distribution of currently lapsed policies.
- What premium exposure is associated with lapsed policies.
- How payment behaviour varies across installment statuses.
- What hypothetical retention scenarios could mean for annualized premium exposure.

## Dataset & Scope

INSURE360 uses a synthetic insurance dataset designed to simulate policy lifecycle, customer, product, distribution channel and premium payment data.

The dataset contains:

| Data Component | Records |
|---|---:|
| Customers | 1,800 |
| Policies | 2,400 |
| Premium Payment Records | 31,186 |
| Policy Snapshot Records | 79,896 |
| Date Dimension | 2,191 |
| Products | 6 |
| Distribution Channels | 5 |
| Geographies | 20 |

The portfolio analysis uses the latest available policy snapshot as of October 31, 2026.

All data used in this project is synthetic and created for analytical and portfolio demonstration purposes. It does not represent real customers, insurance contracts or company performance.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| MySQL | Relational database and data storage |
| SQL | Data validation, querying, aggregation and analytical views |
| Microsoft Excel | Dataset inspection and preliminary analysis |
| Power BI | Interactive dashboards and visual analytics |
| DAX | KPI calculations, measures and scenario analysis |
| GitHub | Project documentation, version control and portfolio presentation |

### Analytical Components

- Relational data modelling
- SQL joins, aggregations and views
- Portfolio KPI analysis
- Payment behaviour analysis
- Policy persistency and lapse analysis
- Risk segmentation
- DAX measures
- Interactive dashboard design
- Hypothetical retention scenario modelling

## Database Architecture

The project uses a relational database structure in MySQL to organize customer, policy, product, channel, geography, date and payment information.

### Tables

| Table | Description |
|---|---|
| `dim_customer` | Customer attributes and geographic references |
| `dim_product` | Insurance product information |
| `dim_channel` | Distribution channel information |
| `dim_geography` | Geographic attributes |
| `dim_date` | Date dimension |
| `dim_policy` | Policy-level attributes and references |
| `fact_premiumpayment` | Installment payment records and payment status |
| `fact_policysnapshot` | Monthly policy status and premium snapshots |

### Analytical Views

- `vw_policy_latest_status` — identifies the latest available snapshot for each policy.
- `vw_portfolio_kpi` — provides portfolio KPI validation.
- `vw_retention_risk` — combines latest policy status with product and distribution channel attributes for retention analysis.

The analytical views were designed to simplify reporting and support consistent portfolio-level analysis.

## Analysis Methodology

The project followed a structured analytical workflow:

1. **Data preparation** — Imported and organised synthetic insurance data into a relational MySQL database.
2. **Data validation** — Checked record counts, transaction uniqueness and data consistency.
3. **SQL analysis** — Used joins, aggregations and analytical views to examine portfolio performance.
4. **Latest snapshot analysis** — Identified the latest available status for each policy to avoid counting historical snapshots as separate policies.
5. **Payment analysis** — Examined installment outcomes across Paid, Paid Late and Missed categories.
6. **Risk segmentation** — Analysed lapsed policies by product, distribution channel, geography and policy age.
7. **Power BI modelling** — Developed measures and interactive visuals for portfolio and retention analysis.
8. **Scenario analysis** — Modelled hypothetical retention percentages to illustrate potential annualized premium exposure preserved.

## Key Business Findings

### Portfolio Overview
- The portfolio contains 2,400 policies across multiple insurance products and distribution channels.
- 1,861 policies are active, representing approximately 77.54% of the portfolio.
- 409 policies are currently lapsed, representing approximately 17.04% of the portfolio.
- 102 policies are surrendered and 28 are matured.

### Lapse Exposure
- Current lapsed policies represent approximately ₹1.34 crore in annualized premium exposure.
- The 37–60 month policy-age band accounts for the largest share of currently lapsed policies, with 176 policies (approximately 43.03%).
- The 13–24 month band accounts for 100 lapsed policies, while the 25–36 month band accounts for 94.
- The 0–12 month band accounts for 39 currently lapsed policies.

### Payment Behaviour
- Approximately 88.99% of payment records are marked Paid.
- Approximately 9.91% are marked Paid Late.
- Approximately 1.11% are marked Missed.

### Distribution Channel & Product Patterns
- Lapse patterns vary across products and distribution channels.
- Certain product-channel combinations show comparatively high lapse proportions; these observations should be interpreted cautiously where segment sample sizes are small.

## Retention Scenario Analysis

A hypothetical retention scenario analysis was developed using the annualized premium exposure associated with currently lapsed policies.

The analysis illustrates how different retention success rates could translate into potential annualized premium exposure preserved.

| Hypothetical Retention Rate | Potential Premium Exposure Preserved |
|---|---:|
| 5% | ₹6.69 lakh |
| 10% | ₹13.38 lakh |
| 15% | ₹20.07 lakh |
| 20% | ₹26.77 lakh |
| 25% | ₹33.46 lakh |
| 30% | ₹40.15 lakh |

These scenarios are illustrative calculations based on the portfolio's current lapsed premium exposure. They are not forecasts, realized revenue, or evidence that a retention intervention would achieve these outcomes.

## Power BI Dashboard

The INSURE360 Power BI report consists of three analytical pages.

### Page 1 — Insurance Portfolio Overview
Provides a high-level view of portfolio performance and payment behaviour.

- Portfolio policy counts and status distribution.
- Active and lapsed policy KPIs.
- Overall lapse rate.
- Annualized premium exposure associated with lapsed policies.
- Premium collections analysis.
- Payment installment behaviour.
- Lapse rate by distribution channel.

### Page 2 — Retention & Risk Analysis
Explores lapse patterns and premium exposure across different portfolio segments.

- Lapsed policies by policy-age band.
- Lapsed premium exposure by policy-age band.
- Lapse analysis by product.
- Lapse analysis by state.
- Interactive product and distribution channel filters.

### Page 3 — Retention Strategy
Illustrates hypothetical retention scenarios.

- Potential premium exposure preserved at different retention success rates.
- Scenario comparison from 5% to 30%.
- Baseline lapsed premium exposure.
- 10% and 30% scenario reference KPIs.
- Scenario table for comparison.

## Limitations & Assumptions

- The dataset is synthetic and does not represent real-world insurance portfolio performance.
- Lapse analysis is based on the latest available policy snapshot dated October 31, 2026.
- Lapsed premium exposure represents annualized premium associated with currently lapsed policies, not realized financial loss.
- Policy-age analysis describes the distribution of currently lapsed policies across age bands; it does not represent age-band-specific lapse probabilities.
- Payment behaviour is evaluated at the installment-record level and should not be interpreted as policy lapse behaviour.
- Retention scenarios are hypothetical and do not represent forecasts, expected outcomes or proven intervention effectiveness.
- Some product-channel combinations contain relatively small sample sizes, which may affect interpretation.

## Business Recommendations

Based on the patterns explored in this synthetic portfolio:

- **Monitor early policy tenure:** Track persistency patterns during the first 36 months and investigate where customer engagement may need improvement.
- **Prioritise lapse exposure:** Use annualized premium exposure alongside policy counts to help prioritise retention analysis.
- **Review channel performance:** Investigate channel-level lapse patterns while accounting for differences in portfolio size and product mix.
- **Monitor payment behaviour:** Track late and missed installments as indicators for further investigation, without treating them as direct predictors of lapse.
- **Segment retention strategies:** Consider product-, tenure- and channel-specific retention approaches rather than relying exclusively on portfolio-wide interventions.
- **Evaluate retention initiatives:** Use measurable outcomes and controlled comparisons where feasible to evaluate whether retention initiatives are effective.

## Project Structure

INSURE360-Insurance-Analytics/
│
├── Dataset/
│   └── INSURE360_dataset_v2.xlsx
│
├── SQL/
│   └── INSURE360_SQL_Analysis.sql
│
├── PowerBI/
│   └── INSURE360.pbix
│
├── Screenshots/
│   ├── portfolio_overview.png
│   ├── retention_risk_analysis.png
│   └── retention_strategy.png
│
└── README.md
└── README.md

> **Note:** The folder structure shown above represents the planned organisation of the project for GitHub. File names and folder organisation will be finalised during project packaging to ensure they reflect the actual project files.

