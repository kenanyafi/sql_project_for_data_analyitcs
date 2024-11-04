WITH SKILLS_DEMAND AS (
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact 
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst' 
        AND job_postings_fact.job_work_from_home = TRUE 
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id,
        skills_dim.skills
),
AVG_SALARY AS (
    SELECT
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
    FROM 
        job_postings_fact 
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst' 
        AND job_postings_fact.job_work_from_home = TRUE 
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id,
        skills_dim.skills
)
SELECT   
    SKILLS_DEMAND.skill_id,
    SKILLS_DEMAND.skills,
    SKILLS_DEMAND.demand_count,
    AVG_SALARY.average_salary
FROM 
    SKILLS_DEMAND
INNER JOIN AVG_SALARY 
    ON SKILLS_DEMAND.skill_id = AVG_SALARY.skill_id
WHERE 
SKILLS_DEMAND.DEMAND_COUNT >10
ORDER BY 
AVG_SALARY.average_salary desc,
DEMAND_COUNT DESC
LIMIT 25 
