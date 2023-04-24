class SalariesSerializer
  include JSONAPI::Serializer 

  set_type :salaries
  set_id { nil }

  
  attribute :destination do |city_data|
    city_data[:weather][:location][:name]
  end

  attribute :forecast do |city_data|
    { 
      summary: city_data[:weather][:current][:condition][:text],
      temperature: city_data[:weather][:current][:temp_f]
    }
  end

  attribute :salaries do |city_data|
    city_data[:salary_data][:salaries].map do |salary|
      if ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"].include?(salary[:job][:title])
        { 
          title: salary[:job][:title],
          min: sprintf("$%.2f", salary[:salary_percentiles][:percentile_25]),
          max: sprintf("$%.2f", salary[:salary_percentiles][:percentile_75])
        }
      end
    end.compact
  end
end