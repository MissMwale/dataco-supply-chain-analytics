# DataCo Smart Supply Chain — Logistics & Delivery Performance Analysis

A end-to-end supply chain analytics case study exploring delivery performance, regional/category trends, and demand forecasting using the [DataCo Smart Supply Chain dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis) (Kaggle).

## 🎯 Project Overview

This project investigates why late deliveries are so common in the DataCo supply chain, whether the problem is concentrated in specific regions, product categories, or shipping methods, and what future order demand is likely to look like. The analysis moves through four tools, each building on the last: **Excel → SQL → Python → Power BI**.

## 🛠️ Tools & Skills Used

- **Excel** — initial data cleaning, exploration, and summary analysis
- **SQL Server** — deeper aggregation and root-cause analysis across regions, categories, and shipping modes
- **Python (Prophet)** — time-series demand forecasting
- **Power BI** — interactive dashboard bringing the findings together

## 🔍 Key Findings

1. **57% of all orders were delivered late** — identified during the initial Excel cleaning and exploration phase.
2. **Late delivery rates are consistent across regions (~55–60%)** and fairly consistent across product categories too — this rules out a regional or product-specific cause.
3. **The real driver is a structural SLA mismatch in First and Second Class shipping** — the *scheduled* delivery window is shorter than the *actual* time these shipping methods typically take. In other words, the SLA promises are misaligned with real-world delivery capability, and this mismatch accounts for most of the late deliveries in the dataset.
4. **Demand forecasting (Prophet):** before modeling, a data quality issue was identified and excluded — order counts began mechanically repeating after 2017-10-02, which would have distorted the forecast if left in. Once cleaned, the model was used to project future order volume.

## 📊 Dashboard

*(Power BI dashboard screenshot to be added here once complete.)*

## 📁 Repository Structure

```
├── excel/              # Initial data cleaning & exploration
├── sql/                # SQL scripts for regional/category/shipping analysis
├── python/             # Data cleaning + Prophet forecasting notebook
├── powerbi/             # Power BI dashboard (.pbix)
└── README.md
```

## 💡 Why This Matters

Late delivery isn't just an operational annoyance — it drives customer churn and erodes trust. This analysis shows that the fix isn't "work faster," it's **reset the SLA promise to match reality** for First and Second Class shipping, which would immediately resolve the majority of reported lateness without changing a single warehouse process.

## 🔮 Next Steps

- Finalize and publish the Power BI dashboard
- Explore cost/service-level tradeoffs of adjusting SLA windows
- Extend forecasting to a category-level breakdown

---
**Author:** Becky — Supply Chain & Procurement Professional transitioning into data analytics.
📫 Connect on [LinkedIn](#) 
