class GlassdoorJobs::Scraper
  
  def self.get_page
    Nokogiri::HTML(open('https://www.glassdoor.com/Salaries/new-york-city-software-engineer-salary-SRCH_IL.0,13_IM615_KO14,31.htm'))
  end

  def self.get_job_list
    self.get_page.css("div.jobTitleContainer.cell.middle")
  end

  def self.create_jobs
    self.get_job_list.each do |job|
      company = job.css("div.small").text
      salary = job.css("div.hideDesk.meanPay.padTop.aboveRangeBar strong").text
      role = job.css("div.employerSalaryInfo.tightVert a.noMargVert.jobTitle").text.strip
      url = 'https://www.glassdoor.com' + job.css("div.employerSalaryInfo.tightVert a.noMargVert.jobTitle").attribute("href").value
      GlassdoorJobs::Job.new(role, company, salary, url)
    end
  end
end
