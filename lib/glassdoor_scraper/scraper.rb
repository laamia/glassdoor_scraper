class GlassdoorJobs::Scraper

  def self.get_page(url)
    Nokogiri::HTML(open(url))
  end

  def self.get_job_list(url)
    self.get_page(url).css("div.jobTitleContainer.cell.middle")
  end

  def self.create_jobs(url)
    self.get_job_list(url).each do |job|
      company = job.css("div.small").text
      salary = job.css("div.hideDesk.meanPay.padTop.aboveRangeBar strong").text
      role = job.css("div.employerSalaryInfo.tightVert a.noMargVert.jobTitle").text.strip
      url = 'https://www.glassdoor.com' + job.css("div.employerSalaryInfo.tightVert a.noMargVert.jobTitle").attribute("href").value
      GlassdoorJobs::Job.new(role, company, salary, url)
    end
  end

  def self.get_job_details(company_name)
    job = GlassdoorJobs::Job.all.find{|job| job.company == company_name}
    job_page = get_page(job.url)
    job.company_url = 'https://www.glassdoor.com' + job_page.css("div.empLinks.tbl a.eiCell.cell.overviews").attribute("href").value
    company_page = get_page(job.company_url)
    other_details = {}
    company_page.css("div.info.flexbox.row.col-hh div.infoEntity").each do |text|
      other_details[text.css("label").text] = text.css("span.value").text
    end

    job.company_rating = company_page.css("div.ratingNum").text
    job.company_size = other_details['Size']
    job.company_revenue = other_details['Revenue']
    job.company_headquarters = other_details['Headquarters']
  end

end
