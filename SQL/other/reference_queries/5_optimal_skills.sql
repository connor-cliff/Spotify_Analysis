/*
Identifying the most optimal skills to learn: those in high demand and offering high salaries.  
Focuses on remote Data Analyst positions with specified salaries.  
Highlights skills that provide both job security (high demand) and strong financial benefits (high salaries),  
offering strategic insights for career development in data analysis.  
*/


WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short =  'Data Analyst' AND
        job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short =  'Data Analyst' AND
        salary_year_avg IS NOT NULL
        -- AND job_work_from_home = TRUE
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE 
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC

LIMIT 25

/*
Summary: The most optimal skills for remote Data Analysts—combining high demand and 
strong salaries—include Terraform, GitLab, and Kafka. 
Other valuable skills are PyTorch, TensorFlow, Airflow, Scala, and Databricks, 
reflecting high-paying roles that blend data analytics with engineering, automation, 
and cloud technologies.

[
  {
    "skill_id": 212,
    "skills": "terraform",
    "demand_count": "30",
    "avg_salary": "146734"
  },
  {
    "skill_id": 220,
    "skills": "gitlab",
    "demand_count": "57",
    "avg_salary": "134126"
  },
  {
    "skill_id": 98,
    "skills": "kafka",
    "demand_count": "81",
    "avg_salary": "129999"
  },
  {
    "skill_id": 101,
    "skills": "pytorch",
    "demand_count": "30",
    "avg_salary": "125226"
  },
  {
    "skill_id": 31,
    "skills": "perl",
    "demand_count": "34",
    "avg_salary": "124686"
  },
  {
    "skill_id": 223,
    "skills": "ansible",
    "demand_count": "12",
    "avg_salary": "124370"
  },
  {
    "skill_id": 99,
    "skills": "tensorflow",
    "demand_count": "47",
    "avg_salary": "120647"
  },
  {
    "skill_id": 63,
    "skills": "cassandra",
    "demand_count": "22",
    "avg_salary": "118407"
  },
  {
    "skill_id": 238,
    "skills": "notion",
    "demand_count": "29",
    "avg_salary": "118092"
  },
  {
    "skill_id": 219,
    "skills": "atlassian",
    "demand_count": "43",
    "avg_salary": "117966"
  },
  {
    "skill_id": 218,
    "skills": "bitbucket",
    "demand_count": "38",
    "avg_salary": "116712"
  },
  {
    "skill_id": 96,
    "skills": "airflow",
    "demand_count": "228",
    "avg_salary": "116387"
  },
  {
    "skill_id": 3,
    "skills": "scala",
    "demand_count": "110",
    "avg_salary": "115480"
  },
  {
    "skill_id": 169,
    "skills": "linux",
    "demand_count": "115",
    "avg_salary": "114883"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "demand_count": "182",
    "avg_salary": "114153"
  },
  {
    "skill_id": 95,
    "skills": "pyspark",
    "demand_count": "111",
    "avg_salary": "114058"
  },
  {
    "skill_id": 62,
    "skills": "mongodb",
    "demand_count": "91",
    "avg_salary": "113608"
  },
  {
    "skill_id": 18,
    "skills": "mongodb",
    "demand_count": "91",
    "avg_salary": "113608"
  },
  {
    "skill_id": 83,
    "skills": "aurora",
    "demand_count": "15",
    "avg_salary": "113394"
  },
  {
    "skill_id": 81,
    "skills": "gcp",
    "demand_count": "271",
    "avg_salary": "113065"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "361",
    "avg_salary": "113002"
  },
  {
    "skill_id": 193,
    "skills": "splunk",
    "demand_count": "48",
    "avg_salary": "112928"
  },
  {
    "skill_id": 75,
    "skills": "databricks",
    "demand_count": "277",
    "avg_salary": "112881"
  },
  {
    "skill_id": 252,
    "skills": "unify",
    "demand_count": "17",
    "avg_salary": "112317"
  },
  {
    "skill_id": 210,
    "skills": "git",
    "demand_count": "270",
    "avg_salary": "112250"
  }
]
*/