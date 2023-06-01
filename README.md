# Jobber
## Framwork: Rails
## Database: Postgresql

See Demo:
<a href="https://jobber-gj34.onrender.com/">
<img src="Jobber.png" alt="Jobber">
</a>

## User Story
### Title
* Job_Finder

### Description
* As a job searcher, I want a platform that can easily search and apply jobs

* As a job searcher, I want to manage to where I applied and my curret application status, so that I don't need other tools/platforms

* As a job searcher, I want to search jobs by job title

* As a job searcher, I want to save the jobs that I favourite

* As a job searcher, I want to know what the job type is (fulltime or parttime)

* As a recruiter, I want to post new jobs, and check the applicants of those jobs

* As a recruiter, I want to change the applicants' application status

* As a recruiter, I want to see applicants' resume

* As a user, I want to change user information


### Acceptance Criteria
* The recruiters are allowed to change applicants' application      status while non-recruiters are not allowed

* Recruiters are not allowed to apply any jobs

* Only users who create a job description can edit and delete those jobs

* the users who write reviews and admin are ONLY allowed to delete them

## Features (Acceptance Criteria)
* User authentication

* Job Search by Title

* Job Categorieså
    Categories(Tagging) each job, so that the job-searchers are able to looking for their favoured jobs

* Applying to Jobs from this website by clicking "Apply" button

* Analytics
    Users can see the applications they submitted

* Mailer Option
    can get notification when the "Favourite" job is updated
    Recruiters can get email when users wrote a review and applied for their jobs

* Add reviews

* Job saved option (users can check them as a list)

* Only recruiters can change applicaiton status

### database
https://github.com/banban-22/job_finder/blob/final/Job_finder_fixed%20ERD.drawio.png