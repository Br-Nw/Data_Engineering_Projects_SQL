/*
Question: What are the highest-paying skills for data engineers in the UK?
- Calculate the median salary for each skill required in data engineer positions
- Focus on Non-remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT skills_dim.skills , ROUND(MEDIAN(job_postings_fact.salary_year_avg), 0) AS median_annual_salary, 
    COUNT(skills_dim.skills) AS listing_count,  
FROM job_postings_fact 
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Engineer' 
    AND job_postings_fact.job_country = 'United Kingdom'
    AND job_postings_fact.job_work_from_home = FALSE
GROUP BY skills_dim.skills
HAVING COUNT(skills_dim.skills) > 100
ORDER BY median_annual_salary DESC, listing_count DESC
LIMIT 25;

/*
Here's a breakdown of the highest-paying skills for Data Engineers in the UK (non-remote roles):

Key Insights:
- SAS is the highest-paying skill in the dataset, with a £162.5K median annual salary across 576 postings.
- TensorFlow and PyTorch both have a £150K median salary, with 229 TensorFlow and 203 PyTorch listings. This suggests strong compensation, although their job volumes are relatively modest.
- Looker stands out as a particularly interesting combination of pay and demand, offering a £148.3K median salary across 665 listings.
- Git, Tableau, MySQL, Linux, Jira, and PowerShell all show a £147.5K median salary. Their listing counts vary substantially, from 255 for Bash to 1,676 for Git.
- Git has the strongest demand among the £147.5K skills, appearing in 1,676 listings, making it one of the more compelling skills when considering both compensation and market presence.
- Tableau and MySQL also combine relatively high pay with substantial demand, appearing in 1,655 and 857 postings, respectively.
- Snowflake and BigQuery are notable because they have much larger listing volumes — 3,294 and 1,475 postings — while still showing a strong £143.4K median salary.
- Airflow is another strong combination of marketability and compensation, with 2,501 listings and a £139.2K median salary.
- Spark and Python have the largest demand among the skills shown, with 4,665 and 14,295 listings respectively. Their median salaries are lower at £134.6K and £131.6K, but their much larger number of opportunities makes them important skills for employability.

Takeaway:
The highest-paying skills aren't necessarily the ones with the largest number of job postings. SAS, TensorFlow, and PyTorch command the highest median salaries, but their demand is relatively limited. For a stronger balance between salary and job-market demand, skills such as Git, Snowflake, BigQuery, Airflow, Spark, and Python stand out.

In particular, Python + Spark + Airflow + Snowflake/BigQuery looks like a strong combination for a Data Engineer aiming to balance high employability with above-average compensation, while skills such as SAS, TensorFlow, and PyTorch could provide additional specialization opportunities.
┌────────────┬──────────────────────┬───────────────┐
│   skills   │ median_annual_salary │ listing_count │
│  varchar   │        double        │     int64     │
├────────────┼──────────────────────┼───────────────┤
│ sas        │             162500.0 │           576 │
│ tensorflow │             150000.0 │           229 │
│ pytorch    │             150000.0 │           203 │
│ looker     │             148290.0 │           665 │
│ git        │             147500.0 │          1676 │
│ tableau    │             147500.0 │          1655 │
│ mysql      │             147500.0 │           857 │
│ linux      │             147500.0 │           701 │
│ jira       │             147500.0 │           625 │
│ powershell │             147500.0 │           478 │
│ dax        │             147500.0 │           390 │
│ gitlab     │             147500.0 │           302 │
│ confluence │             147500.0 │           283 │
│ bash       │             147500.0 │           255 │
│ ruby       │             147500.0 │           202 │
│ typescript │             147500.0 │           164 │
│ snowflake  │             143358.0 │          3294 │
│ bigquery   │             143358.0 │          1475 │
│ airflow    │             139216.0 │          2501 │
│ ssrs       │             138982.0 │           649 │
│ word       │             135588.0 │           248 │
│ spark      │             134621.0 │          4665 │
│ c++        │             134241.0 │           440 │
│ terraform  │             133290.0 │          1613 │
│ python     │             131580.0 │         14295 │
└────────────┴──────────────────────┴───────────────┘
*/