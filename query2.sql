with top_paying_jobs as (
    select 
   job_id,
    job_title,
    salary_year_avg,
    company_dim.name as company_name
    FROM
    job_postings_fact
LEFT JOIN company_dim on company_dim.company_id=job_postings_fact.company_id
WHERE
        job_title_short='Data Analyst' AND
        job_location='Anywhere'
        and salary_year_avg is not null

order by salary_year_avg desc
limit 10
)
select top_paying_jobs.*,skills from top_paying_jobs 
inner join skills_job_dim on top_paying_jobs.job_id=skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
order by salary_year_avg desc;