SELECT 
    skills,
    count(skills_job_dim.job_id) as demand_count,
    round(avg( salary_year_avg),0) as average_salary


from job_postings_fact 
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
WHERE 
    job_title_short='Data Analyst' AND
    job_work_from_home=TRUE and
   salary_year_avg is not null
GROUP BY 

    skills
ORDER BY
    average_salary desc
limit 25