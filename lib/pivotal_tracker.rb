class PivotalTracker

  def get_projects(token)
    conn = Faraday.new(url: "https://www.pivotaltracker.com")

    response = conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end

    if response.success?
      response_json = JSON.parse(response.body, symbolize_names: true)
    end

    names_and_ids = {}
    response_json.each do |project|
      names_and_ids[project[:name]] = project[:id]
    end
    names_and_ids
  end

  def get_stories(project_id, token)
    conn = Faraday.new(url: "https://www.pivotaltracker.com")

    response = conn.get do |req|
      req.url "/services/v5/projects/#{project_id}/stories?date_format=millis"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end

    if response.success?
      response_json = JSON.parse(response.body, symbolize_names: true)
    end

    stories = []
    response_json.each do |item|
      story = {}
      story[:description] = item[:name]
      story[:estimate] = item[:estimate]
      story[:current_state] = item[:current_state]

      story[:labels] = []
      item[:labels].each do |label|
        story[:labels] << label[:name]
      end

      stories << story
    end

    stories
  end

end
