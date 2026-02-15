/*
Calculating the number of remote job postings per skill.  
Displaying the top 5 skills by demand in remote jobs,  
including skill ID, skill name, and the count of postings requiring each skill.  
*/

SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short =  'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5

/*
Summary: The query identified the top five most in-demand skills for remote 
Data Analyst job postings. SQL is the most required skill, appearing in 7,291 
postings, followed by Excel (4,611), Python (4,330), Tableau (3,745), and 
Power BI (2,609).

[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/