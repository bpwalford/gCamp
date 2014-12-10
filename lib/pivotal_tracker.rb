class PivotalTracker

  def get_projects(token)
    data = send_request("/services/v5/projects", token)

    names_and_ids = {}
    data.each do |project|
      names_and_ids[project[:name]] = project[:id]
    end

    names_and_ids
  end

  def get_stories(project_id, token)

    data = []
    data << send_request("/services/v5/projects/#{project_id}/stories?with_state=rejected", token)
    data << send_request("/services/v5/projects/#{project_id}/stories?with_state=started", token)
    data << send_request("/services/v5/projects/#{project_id}/stories?with_state=unstarted", token)
    data << send_request("/services/v5/projects/#{project_id}/stories?with_state=finished", token)
    data << send_request("/services/v5/projects/#{project_id}/stories?with_state=delivered", token)
    data << send_request("/services/v5/projects/#{project_id}/stories?with_state=accepted", token)

    stories = []
    data.each do |datum|
      datum.each do |item|
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
    end

    while stories.length > 500
      stories.pop
    end

    stories
  end

  private

  def send_request(path, token)

    conn = Faraday.new(url: "https://www.pivotaltracker.com")

    response = conn.get do |req|
      req.url path
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end

    if response.success?
      response_json = JSON.parse(response.body, symbolize_names: true)
    end

    response_json

  end

end
