# Nashville Real Estate Analysis

### Project Overview 
This data analysis project aims to provide insights into the real estate market across the greater Nashville, Tennessee area. By analyzing various factors related to property sales from 2013 to 2016, the goal is to identify key market trends and generate data-driven recommendations that deliver actionable value to a real estate agency.

Insights and recommendations are provided on the following key areas:
- **Market Trends Over Time**: Examines the relationship between the average total property value and average sale price across different land use types and analyzes the volatility of different property types over time.
- **Return on Investment (ROI)** by land use type.
- **Regional Comparison**: Margin of profit and land values across various areas of Nashville.

### Data Structure

The original Nashville housing dataset had the bellow the structrure and included 1,048,575 records.
![Screenshot (71)](https://github.com/user-attachments/assets/6ee86f32-b7b3-4633-98fb-ea36678f92bb)


The SQL queries that were used to cunduct the cleaning of the dataset can be found [here](https://github.com/panoslamp/Data_analytics_project/blob/main/nashville%20housing%20cleaning.sql)

### Results / Findings
Below is the overview page from the Power BI dashboard. The entire interactive dashboard can be downloaded [here]

![Screenshot (76)](https://github.com/user-attachments/assets/8d78d0c9-03f0-45b0-b961-42beb09700ef)
#### Market trend overview

A major market shift was observed in early 2014.

- From January 2013 to February 2014: The average total property value exceeded the average sale price across 5,990 transactions, suggesting a buyer's market or undervalued sales.

- Since March 2014, this trend reversed, average sale prices have exceeded average total values, indicating increasing demand, potential property appreciation, and a shift toward a seller’s market.

#### Property type stability
- Zero Lot Line properties demonstrate consistent performance and are among the most stable land use types. Notably, they maintained a positive profit margin even during the 2013 downturn, indicating resilience in fluctuating market conditions.
- Vacant Residential Land is significantly more volatile and best suited for high-risk, high-reward investment strategies. This category experienced a dramatic loss in 2013, with an average deficit of $110,057, followed by a strong rebound in 2015, posting an average profit of $259,622. These large fluctuations highlight the unpredictability of this property type over time.


#### Return on Investment (ROI) by Land Use

- Duplex properties offer a significantly high average ROI of 42.86%, making them attractive for short-term profit.
- Zero Lot Line properties follows with an ROI of 24.54%.
- Single Family properties, while the most common property type in the dataset, trail behind at 15.78%.
- Vacant Residential Land offers the highest profit margin (62,73%), signaling both risk and reward potential.

#### Geographic analysis
- Brentwood, although rural, records the highest land value at $7,035 per acre (203 records), though it offers low profit margin (9,88%). Also, Old hickory represents a similar situation with a relatively high land value of $2,886 per acre and modest returns.
- Nashville city center ranks second with a land value of $4,985 per acre (20,418 records) combining high values with solids returns.
- Rural areas such as Antioch, Madison, Hermitage, and Goodlettsville report lower land values ranging from $1,337 to $1,736 per acre.
- Antioch has the highest average ROI at 21.08%, followed by Nashville city center and Hermitage, both exceeding the regional average of 19.35%. Notably, Antioch and Hermitage also feature relatively low land costs, making them particularly attractive for value-driven investment opportunities.
- In contrast, Brentwood, Old Hickory, and Goodlettsville fall below the regional average, with average ROI in the 9–10% range. In particular, Brentwood's high land costs present a higher-risk investment, as the elevated entry price is not matched by a proportional return.


### Recommendations


