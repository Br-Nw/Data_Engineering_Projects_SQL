/*
Question: What are the most in-demand skills for data engineers in the UK?
- Identify the top 10 in-demand skills for data engineers
- Focus on non-remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the non-remote job market,
    providing insights into the most valuable skills for data engineers seeking non-remote work within
    the united kingdom
*/

SELECT skills_dim.skills AS "Top_skills(Non-remote)", COUNT(skills_dim.skills) AS Demand_count FROM job_postings_fact 
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Engineer' 
    AND job_postings_fact.job_country = 'United Kingdom' 
    AND job_postings_fact.job_work_from_home = FALSE 
GROUP BY skills_dim.skills
ORDER BY Demand_count DESC
LIMIT 10;
/*

Insights:
SQL and Python are by far the most in-demand skills, with around 15-14000 listing it as a requirement
Cloud platforms round out the top skills, with Azure leading at ~10,000 postings, followed by AWS at ~8000.
Databricks completes the top 5 with nearly 4785 postings, being a widely used data platform.
Spark comes just 6th with ~4000 postings highlighting the importance of big data processing skills

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and GCP round out the top 10 most requested skills

┌────────────────────────┬──────────────┐
│ Top_skills(Non-remote) │ Demand_count │
│        varchar         │    int64     │
├────────────────────────┼──────────────┤
│ sql                    │        15264 │
│ python                 │        14295 │
│ azure                  │        10958 │
│ aws                    │         8395 │
│ databricks             │         4785 │
│ spark                  │         4665 │
│ gcp                    │         3490 │
│ power bi               │         3430 │
│ snowflake              │         3294 │
│ java                   │         3066 │
└────────────────────────┴──────────────┘
  10 rows                     2 columns
*\