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

end
