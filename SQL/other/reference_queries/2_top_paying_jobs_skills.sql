/*
Identify the specific skills required for the top 10 highest paying Data Analyst jobs 
provide a detailed view of which skills are most in demand for high-salary roles to help 
job seekers understand which skills to focus on for top paying opportunities.
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_country = 'United Kingdom' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC

/*
Summary:
The top paying Data Analyst jobs in the UK demand strong technical and data-handling skills. 
Python and SQL are the most valuable, appearing in nearly all high-salary roles. Excel, AWS, and 
Azure remain essential for data management and reporting, while advanced tools like TensorFlow, 
PyTorch, and Power BI boost earning potential.

[
  {
    "job_id": 1401033,
    "job_title": "Market Data Lead Analyst",
    "salary_year_avg": "180000.0",
    "company_name": "Deutsche Bank",
    "skills": "excel"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "company_name": "DeepMind",
    "skills": "python"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "company_name": "DeepMind",
    "skills": "c++"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "company_name": "DeepMind",
    "skills": "pandas"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "company_name": "DeepMind",
    "skills": "numpy"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "company_name": "DeepMind",
    "skills": "tensorflow"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "company_name": "DeepMind",
    "skills": "pytorch"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "Darktrace",
    "skills": "sql"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "Darktrace",
    "skills": "mysql"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "Darktrace",
    "skills": "sql server"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "Darktrace",
    "skills": "flow"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "salary_year_avg": "165000.0",
    "company_name": "Plexus Resource Solutions",
    "skills": "python"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "salary_year_avg": "165000.0",
    "company_name": "Plexus Resource Solutions",
    "skills": "mysql"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "salary_year_avg": "165000.0",
    "company_name": "Plexus Resource Solutions",
    "skills": "aws"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "sql"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "python"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "scala"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "r"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "mongodb"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "postgresql"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "elasticsearch"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "sql server"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "mongodb"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "azure"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "aws"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "redshift"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "oracle"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "aurora"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "hadoop"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "company_name": "AND Digital",
    "skills": "kafka"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "salary_year_avg": "163782.0",
    "company_name": "Logispin",
    "skills": "nosql"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "salary_year_avg": "163782.0",
    "company_name": "Logispin",
    "skills": "azure"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "salary_year_avg": "163782.0",
    "company_name": "Logispin",
    "skills": "looker"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "salary_year_avg": "156500.0",
    "company_name": "Shell",
    "skills": "shell"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "salary_year_avg": "156500.0",
    "company_name": "Shell",
    "skills": "express"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "salary_year_avg": "156500.0",
    "company_name": "Shell",
    "skills": "excel"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "salary_year_avg": "156500.0",
    "company_name": "Shell",
    "skills": "flow"
  },
  {
    "job_id": 217504,
    "job_title": "Analytics Engineer - ENA London, Warsaw- (F/M)",
    "salary_year_avg": "139216.0",
    "company_name": "AccorCorpo",
    "skills": "sql"
  },
  {
    "job_id": 217504,
    "job_title": "Analytics Engineer - ENA London, Warsaw- (F/M)",
    "salary_year_avg": "139216.0",
    "company_name": "AccorCorpo",
    "skills": "python"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "company_name": "AJ Bell",
    "skills": "sql"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "company_name": "AJ Bell",
    "skills": "python"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "company_name": "AJ Bell",
    "skills": "r"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "company_name": "AJ Bell",
    "skills": "excel"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "company_name": "AJ Bell",
    "skills": "power bi"
  }
]
*/