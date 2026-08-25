/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
*/

SELECT skills_dim.skills , 
    ROUND(MEDIAN(job_postings_fact.salary_year_avg), 0) AS median_annual_salary,  
    COUNT(job_postings_fact.*) AS demand_count,
    ROUND(LN(COUNT(job_postings_fact.*)), 1) AS ln_demand_count,
    ROUND(MEDIAN(job_postings_fact.salary_year_avg) * LN(COUNT(job_postings_fact.*)) / 1_000_000, 2) AS optimal_score
FROM job_postings_fact 
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Engineer' 
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY skills_dim.skills
HAVING COUNT(skills_dim.skills) > 100
ORDER BY optimal_score DESC
LIMIT 25;

/*
┌────────────┬──────────────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_annual_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │        double        │    int64     │     double      │    double     │
├────────────┼──────────────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │             184000.0 │          193 │             5.3 │          0.97 │
│ python     │             135000.0 │         1133 │             7.0 │          0.95 │
│ sql        │             130000.0 │         1128 │             7.0 │          0.91 │
│ aws        │             137320.0 │          783 │             6.7 │          0.91 │
│ airflow    │             150000.0 │          386 │             6.0 │          0.89 │
│ spark      │             140000.0 │          503 │             6.2 │          0.87 │
│ snowflake  │             135500.0 │          438 │             6.1 │          0.82 │
│ kafka      │             145000.0 │          292 │             5.7 │          0.82 │
│ azure      │             128000.0 │          475 │             6.2 │          0.79 │
│ java       │             135000.0 │          303 │             5.7 │          0.77 │
│ scala      │             137290.0 │          247 │             5.5 │          0.76 │
│ git        │             140000.0 │          208 │             5.3 │          0.75 │
│ kubernetes │             150500.0 │          147 │             5.0 │          0.75 │
│ databricks │             132750.0 │          266 │             5.6 │          0.74 │
│ redshift   │             130000.0 │          274 │             5.6 │          0.73 │
│ gcp        │             136000.0 │          196 │             5.3 │          0.72 │
│ nosql      │             134415.0 │          193 │             5.3 │          0.71 │
│ hadoop     │             135000.0 │          198 │             5.3 │          0.71 │
│ pyspark    │             140000.0 │          152 │             5.0 │           0.7 │
│ mongodb    │             135750.0 │          136 │             4.9 │          0.67 │
│ docker     │             135000.0 │          144 │             5.0 │          0.67 │
│ r          │             134775.0 │          133 │             4.9 │          0.66 │
│ go         │             140000.0 │          113 │             4.7 │          0.66 │
│ github     │             135000.0 │          127 │             4.8 │          0.65 │
│ bigquery   │             135000.0 │          123 │             4.8 │          0.65 │
└────────────┴──────────────────────┴──────────────┴─────────────────┴───────────────┘
  25 rows 5 columns     
  
Here's a breakdown of the optimal skills for Data Engineers, based on a combination of salary and demand:

Key Insights:
- Terraform has the highest optimal score at 0.97, making it the strongest overall skill in the dataset. It also offers the highest median salary at £184K, although demand is relatively lower at 193 postings.
- Python ranks second with an optimal score of 0.95. Its £135K median salary is lower than Terraform, but its very strong demand of 1,133 postings makes it one of the most valuable skills overall.
- SQL also performs extremely well with a 0.91 optimal score and 1,128 postings. Its £130K median salary is lower than many other skills, but its exceptionally high demand makes it a strong career skill.
- AWS has an optimal score of 0.91, combining a £137.3K median salary with 783 postings. This makes it one of the strongest cloud skills in the dataset.
- Airflow ranks highly with an optimal score of 0.89, offering a £150K median salary across 386 postings.
- Spark has an optimal score of 0.87, with a £140K median salary and 503 postings, giving it a strong balance between compensation and demand.
- Snowflake and Kafka both score 0.82. Snowflake has 438 postings at £135.5K, while Kafka has 292 postings at a higher £145K median salary.
- Azure scores 0.79 with 475 postings and a £128K median salary, showing strong demand despite having a lower salary than many of the other top-ranked skills.
- Java and Scala also provide a good balance of salary and demand, scoring 0.77 and 0.76 respectively.
- Kubernetes has a relatively small demand count of 147 postings but offers a very high £150.5K median salary, resulting in an optimal score of 0.75.
- Databricks, Redshift, GCP, and Hadoop all sit in the mid-to-high range, suggesting they provide useful combinations of compensation and market demand.

Takeaway:
The optimal score highlights that the best skills aren't simply the highest-paying or most frequently requested individually. Instead, the strongest skills balance both compensation and market demand.

Terraform is the standout skill, combining the highest salary (£184K) with a very strong optimal score of 0.97. However, Python and SQL may be more practical for maximizing job opportunities because they appear in over 1,100 postings each.

For a Data Engineer looking to build a strong overall skill set, Python + SQL + AWS + Airflow + Spark provides an excellent combination of high demand, strong salaries, and consistently high optimal scores.