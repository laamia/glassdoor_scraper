class GlassdoorJobs::CLI
  def call
    #Welcome
    GlassdoorJobs::Scraper.get_page('https://www.glassdoor.com/Salaries/new-york-city-software-engineer-salary-SRCH_IL.0,13_IM615_KO14,31.htm')
    GlassdoorJobs::Scraper.create_jobs('https://www.glassdoor.com/Salaries/new-york-city-software-engineer-salary-SRCH_IL.0,13_IM615_KO14,31.htm')
    puts "Hi there! Let's learn about Software Engineering jobs openings in NYC!"
    start
  end

  def start
    display_jobs
    puts "Which job would you like to learn more about?"
    input = gets.strip
    #drilldown?
    if input.to_i > 0
      #list job details
      #GlassdoorJobs::Job.all[input.to_i - 1].get_job_details
      company_name = GlassdoorJobs::Job.all[input.to_i - 1].company
      GlassdoorJobs::Scraper.get_job_details(company_name)
      display_job_details(input.to_i - 1)
      puts "Want to try again? (y/n)"
      input = gets.strip.downcase
      if input == "y"
        start
      elsif input == "n"
        puts "Had enough job hunting? I feel you. See ya later."
      end
    else
      puts "I'm sorry, I don't understand that input, please select the number job you'd like to view."
      start
    end
  end

  def display_jobs
    i = 1
    GlassdoorJobs::Job.all.each do |job|
      puts "#{i.to_s}. #{job.role} - #{job.company} - #{job.salary}"
      i += 1
    end
  end

  def display_job_details(input)
    job = GlassdoorJobs::Job.all[input]
    puts "------------------------------------"
    puts "#{job.role} at #{job.company}"
    puts "Average Salary: #{job.salary}"
    puts "Company Rating: #{job.company_rating} stars"
    puts "Company Headquarters: #{job.company_headquarters}"
    puts "Company Size: #{job.company_size}"
    puts "Company Revenue: #{job.company_revenue}"
    puts "------------------------------------"
  end
end
