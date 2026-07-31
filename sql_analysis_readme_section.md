### SQL Analysis

Using SQL Server, I investigated the drivers behind the dataset's 57.3% late delivery rate across three dimensions: region, shipping mode, and product category.

**Key finding:** Late delivery is not a geography or product problem — rates are fairly consistent across regions (~55–60%) and product categories, with no major outliers. The real driver is **shipping mode SLA design**. First Class orders are late 100% of the time because the promised delivery window (1 day) doesn't match actual fulfillment capability (2 days on average). Second Class shows the same pattern (2-day promise, 4-day actual). Standard Class, the slowest option, is paradoxically the most reliable — because its 4-day promise matches what the business actually delivers.

**Recommendation:** Reset expedited shipping SLAs to reflect real fulfillment capability, or invest in fulfillment speed to close the gap — rather than pursuing region- or product-specific fixes.

Queries are documented in [`sql/supply_chain_analysis.sql`](sql/supply_chain_analysis.sql).
