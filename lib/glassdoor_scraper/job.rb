class GlassdoorJobs::Job
  attr_accessor :role, :company, :salary, :url, :company_url, :company_size, :company_revenue, :company_rating, :company_headquarters
  @@all = []

  def initialize(role, company, salary, url)
    @role = role
    @company = company
    @salary = salary
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def get_job_details
    job_page = Nokogiri::HTML(open(self.url))
    self.company_url = 'https://www.glassdoor.com' + job_page.css("div.empLinks.tbl a.eiCell.cell.overviews").attribute("href").value
    company_page = Nokogiri::HTML(open(self.company_url))

    @company_rating = company_page.css("div.ratingNum").text

    other_details = {}
    company_page.css("div.info.flexbox.row.col-hh div.infoEntity").each do |text|
      other_details[text.css("label").text] = text.css("span.value").text
    end

    @company_size = other_details['Size']
    @company_revenue = other_details['Revenue']
    @company_headquarters = other_details['Headquarters']
  end
end
