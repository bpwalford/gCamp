class PivotalTracker

  def get_projects(token)
    conn = Faraday.new(url: "https://www.pivotaltracker.com/services/v5/projects")

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

  end

end
