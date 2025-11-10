CREATE TABLE job_applied(
  job_id INT,
  application_sent_date DATE, 
  custom_resume BOOLEAN, 
  resume_file_name VARCHAR (255),
  cover_letter_sent BOOLEAN, 
  cover_letter_file_name VARCHAR(255), 
  status VARCHAR(50)


);

SELECT * 
FROM job_applied

INSERT INTO job_applied(
  job_id,
  application_sent_date, 
  custom_resume, 
  resume_file_name,
  cover_letter_sent, 
  cover_letter_file_name, 
  status
)
VALUES (
  1,
  '2025-11-07',
  true,
  'resume_01.pdf',
  true,
  'cover_letter_01.pdf',
  'submitted'
),
(2, '2025-11-05', FALSE, 'default_resume.pdf', FALSE, NULL, 'pending review'),
(3, '2025-11-03', TRUE, 'resume_data_analyst.pdf', TRUE, 'cover_data_analyst.pdf', 'shortlisted'),
(4, '2025-11-01', TRUE, 'resume_dev.pdf', FALSE, NULL, 'interview scheduled'),
(5, '2025-10-28', FALSE, 'general_resume.pdf', TRUE, 'cover_generic.pdf', 'rejected'),
(6, '2025-10-25', TRUE, 'resume_marketing.pdf', TRUE, 'cover_marketing.pdf', 'offer received'),
(7, '2025-10-20', TRUE, 'resume_finance.pdf', FALSE, NULL, 'withdrawn'),
(8, '2025-10-18', FALSE, 'resume_admin.pdf', TRUE, 'cover_admin.pdf', 'submitted'),
(9, '2025-10-15', TRUE, 'resume_hr.pdf', TRUE, 'cover_hr.pdf', 'pending feedback'),
(10, '2025-10-10', TRUE, 'resume_it_support.pdf', FALSE, NULL, 'submitted');

ALTER TABLE job_applied ADD contact VARCHAR(50);

UPDATE job_applied 
SET contact='Robert Owuor'
where job_id=1;

UPDATE job_applied 
SET contact = 'Jane Mwangi'
WHERE job_id = 2;

UPDATE job_applied 
SET contact = 'Michael Otieno'
WHERE job_id = 3;

UPDATE job_applied 
SET contact = 'Sarah Njeri'
WHERE job_id = 4;

UPDATE job_applied 
SET contact = 'David Kamau'
WHERE job_id = 5;

ALTER TABLE job_applied 
RENAME COLUMN contact TO contact_name

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_name;