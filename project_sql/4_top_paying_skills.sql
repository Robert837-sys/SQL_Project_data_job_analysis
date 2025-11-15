-- Top skills based on salary
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short='Data Analyst' AND salary_year_avg IS NOT NULL AND job_work_from_home=True
-- AND job_work_from_home=True
GROUP BY skills
ORDER BY
    avg_salary DESC
LIMIT 25

/*
✅ Top Insights About the Highest-Paying Data Analyst Skills
1. Big Data & Distributed Computing Pay the Most

The top-paying skills are strongly linked to big data processing and distributed systems:

PySpark ($208k)

Databricks ($141k)

Airflow ($126k)

Trend: Companies are paying premium salaries for analysts who can process massive datasets and automate pipelines.
This aligns with the rise of data engineering and cloud analytics.

2. DevOps & Version Control Skills Are Highly Valued

Several DevOps-related tools appear in the top 10:

Bitbucket ($189k)

GitLab ($154k)

Jenkins ($125k)

Atlassian ($131k)

Trend: Data analysts who can collaborate like engineers—and understand CI/CD workflows—earn higher salaries.

3. Advanced Machine Learning Libraries Raise Earning Potential

High-paying ML/AI tools include:

DataRobot ($155k)

Scikit-learn ($125k)

Jupyter ($152k)

Pandas ($151k)

NumPy ($143k)

Trend: Companies want analysts who can move beyond dashboards and perform predictive analytics + ML modeling.

4. Cloud Skills Are Now Mandatory for Top Salaries

Cloud-related skills show up throughout the list:

GCP ($122k)

Kubernetes ($132k)

Trend: Modern analytics runs in the cloud. Analysts with cloud computing + containerization earn more.

5. Programming Languages Beyond Python Are In Demand

Interesting high-paying languages include:

Swift ($153k)

Go / Golang ($145k)

Scala ($124k)

Trend: Companies hiring data analysts increasingly want people with software engineering capability.

6. Specialized Databases Increase Pay

Skills:

Couchbase ($160k) (NoSQL database)

PostgreSQL ($123k)

Elasticsearch ($145k)

Trend: Structured + unstructured data experience = higher salary.

7. Knowledge Management, Communication & Workflow Tools Matter

Notion ($125k)

Atlassian ($131k)

Trend: Analysts supporting collaboration, documentation, and project workflows are highly valued.

📌 Summary of Trends
Trend	Explanation
Data Engineering Skills Pay the Most	PySpark, Databricks, Airflow dominate the top.
DevOps Knowledge = Salary Boost	GitLab, Jenkins, Atlassian show strong demand.
Machine Learning Is Critical	Pandas, NumPy, scikit-learn all pay over $120k+.
Cloud Is Non-Negotiable	GCP & Kubernetes are essential for modern analytics.
Hybrid Analyst-Engineer Roles Pay Best	Skills like Go, Scala, Linux lead to higher roles.
Specialized Databases Increase Value	Couchbase, Elasticsearch highlight demand for NoSQL.
[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salary": "141907"
  },
  {
    "skills": "linux",
    "avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills": "notion",
    "avg_salary": "125000"
  },
  {
    "skills": "scala",
    "avg_salary": "124903"
  },
  {
    "skills": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skills": "gcp",
    "avg_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "121619"
  }
]
*/