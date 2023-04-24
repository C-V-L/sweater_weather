class TeleportService
  def self.conn
    Faraday.new('https://api.teleport.org')
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_salary_data(city)
    get_url("/api/urban_areas/slug:#{city}/salaries/")
  end
end