# Insight Memo — E-Commerce Customer & Revenue Analytics

**Prepared by:** Vishakha Sirwani  
**Audience:** Commercial and Growth teams  
**Dataset:** UCI Online Retail II  
**Period:** December 1, 2009 to December 9, 2011

## Executive Summary

The analysis covers 1,067,371 raw transaction rows and 1,003,340 cleaned sales lines, representing 39,516 invoices, 5,852 identified customers and 43 countries.

Sales revenue before returns totals £19,643,861.62. Revenue is concentrated in the UK and a relatively small group of identified customers. November is the highest-revenue month in both 2010 and 2011.

Recommended next steps are to test customer retention campaigns, prepare for seasonal demand and investigate unusually large cancellations. These recommendations have not been implemented or evaluated.

## Key Findings

### 1. Geographic Concentration

The UK accounts for 85.53% of total sales revenue, or £16,801,019.37.

This concentration creates dependence on one market. International expansion would require additional evidence about demand, margins and delivery costs.

### 2. Customer Segmentation and Revenue Concentration

SQL, Python and dashboard exports produce matching segment summaries:

| Segment | Customers | Customer Share | Revenue Share |
|---|---:|---:|---:|
| Champions | 1,460 | 24.9% | 68.8% |
| Loyal Customers | 1,220 | 20.8% | 14.6% |
| At Risk | 830 | 14.2% | 9.4% |
| New / Potential Loyalists | 449 | 7.7% | 2.4% |
| Hibernating | 701 | 12.0% | 2.0% |
| Lost | 809 | 13.8% | 1.6% |
| Promising | 383 | 6.5% | 1.2% |

Shares use identified customers and their sales revenue. Rounded percentages may not total exactly 100%.

The top 10 customers account for 16.1% of identified-customer sales revenue; the top 100 account for 37.6%. Approximately 23.1% of identified customers generate 80% of this revenue.

Segment labels describe historical purchasing behaviour. They do not establish why customers stopped purchasing or predict future behaviour.

### 3. Repeat Purchases and Cohorts

Overall, 72.4% of identified customers have at least two distinct sales invoices during the observed dataset period.

For the December 2009 cohort:
- Cohort size: 951 customers.
- Active in January 2010: 333 customers, or 35.0%.
- Active 12 months later: 37.6%.

Monthly cohort activity measures purchases in a particular month. It does not require customers to purchase continuously in every preceding month. Failure to return the next month does not establish permanent customer loss.

### 4. Returns and Cancellations

Recorded cancellation value totals £716,425.97:
- Return value divided by sales revenue: 3.65%.
- Returned units divided by sold units: 4.18%.

Product 23843 has £168,469.60 in sales revenue on one invoice and the same total cancellation value. This is an anomaly worth investigating, rather than evidence of a specific product-quality problem.

Cancellation records alone do not establish the reason for a return or whether every cancellation represents a physical product return.

### 5. Monthly Revenue

November revenue reaches:
- November 2010: £1,429,700.78.
- November 2011: £1,452,115.98.

This repeated peak suggests a seasonal pattern in the observed period. Two years of data do not guarantee the same pattern in future years.

December 2011 is incomplete and should not be compared directly with full months.

## Recommended Actions

1. **Test retention offers for high-value segments.** Evaluate incremental repeat purchases and margin against a control group.
2. **Test reactivation campaigns for the historical At Risk segment.** Measure campaign cost, response and incremental sales before judging effectiveness.
3. **Investigate large cancellations.** Review associated invoices and operational records before recommending changes to products or fulfilment.
4. **Prepare for possible seasonal demand.** Use the November pattern alongside inventory, lead-time and margin information.
5. **Monitor customer and geographic concentration.** Track dependence on major accounts and the UK market.

No campaign ROI, revenue increase or reduction in returns has been measured in this project.

## Methodology

- Removed exact duplicate transaction rows.
- Separated cancellation records from cleaned sales.
- Excluded specified non-product service codes and sales lines with non-positive quantity or price.
- Retained unidentified sales for total revenue analysis.
- Used identified customers for segmentation, cohorts and customer concentration.
- Executed SQL analyses using SQLite through Python.
- Updated Python segmentation to reuse the SQL scoring logic.
- Exported aggregated CSV files and built a Tableau Public dashboard.

## Limitations

- Findings apply to one retailer and the historical dataset period.
- December 2011 contains transactions only through December 9.
- 226,761 cleaned sales lines, or 22.6%, lack a customer ID.
- Customer revenue shares exclude unidentified sales.
- Sales revenue is before cancellations and is not profit.
- Cohorts use the first purchase observed in the dataset, which may not be a customer's first-ever purchase.
- Customers have different observation lengths; the overall repeat-purchase rate is not a lifetime retention measure.
- Segment labels use recency and frequency rules; monetary values are also calculated.
- Product margins, marketing costs and cancellation reasons are unavailable.

## Live Dashboard

[View Tableau Dashboard](https://public.tableau.com/app/profile/vishakha.sirwani/viz/E-CommerceCustomerRevenueAnalytics_/RetailAnalyticsDashboard)

## Attribution

This project is adapted from ndkn-code/online-retail-analytics. Credit for the original code and project structure belongs to the original author. My contributions include running and validating the analyses, aligning Python segmentation with SQL, updating documentation and building the Tableau dashboard.
