class ResumeCli::Models::Linkedin

  WHITE = '#fff'
  ORANGE = 'orange'

  def self.basic
    fields = ['first-name', 'last-name', 'headline', 'location:(name)', 'skills', 'member-url-resources']
    p = linkedin(fields)

    message = "\n"
    message << color(WHITE, "#{p[:firstName]} #{p[:lastName]}\n")
    message << color(ORANGE, "#{p[:headline]}\n")
    message << color('#009D9C', "#{p[:location]['name']}\n\n")
  
    message << "Skills: "
    p[:skills]['values'].each_with_index do |skill, num|
      message << skill['skill']['name'] if num == 0
      break if num > 5
      message << ', ' << skill['skill']['name'] unless num == 0
    end

    message << "\n"
    if p[:memberUrlResources]
      p[:memberUrlResources]['values'].each do |url_info|
        message << url_info['name'] << ": " << url_info['url'] << "\n"
      end
    end
    return message
  end  

  def self.education
    fields = ['educations']
    p = linkedin(fields)

    message = "\n"
    p[:educations]['values'].each do |edu|
       message << "[[;orange;]#{edu['degree']}] from [[;orange;]#{edu['schoolName']}], "
       message << "[[;#009D9C;]#{edu['startDate']['year']} - #{ edu['endDate']['year']}]\n"
       message << "[[;white;]#{edu['fieldOfStudy']}]\n"
       message << "#{edu['notes'] ? word_wrap(edu['notes']) : ''}\n\n"
    end
    return message
  end
  
  def self.positions
    fields = ['positions']
    p = linkedin(fields)
    all_positions = p[:positions]['values'].group_by {|i| i['isCurrent']}

    current_positions = all_positions[true]
    previous_positions = all_positions[false]


    message = "\n[[;white;]Current Positions]\n"
    message << "[[;white;]" << "-" * 17 << "]\n\n"
    current_positions.each do |cp|
      message << position_message_creater(cp, true)
    end


    message << "[[;white;]Past Positions]\n"
    message << "[[;white;]" << "-" * 15 << "]\n\n"
    previous_positions.each do |pp|
      message << position_message_creater(pp, false)
    end

    message
  end

  def self.projects
    message = "\n"
    PROJECTS['main'].each do |key, project|
      message << color(ORANGE, "#{project["title"]}: ") << color('#009D9C', word_wrap(project["description"])) << "\n"
      message << project["link"] << "\n\n"
    end
    return message
  end

  def self.help
    message = "List of supported commands:\n"
    message << color(WHITE, 'basic') << ": Get the basic profile\n" 
    message << color(WHITE, 'positions|pos|exp') << ": Get the positions that I have held over the years\n" 
    message << color(WHITE, 'education|edu') << ": Education history\n" 
    message << color(WHITE, 'projects|pro') << ": List of my projects\n" 
    message << color(WHITE, 'recommendations|reco') << ": LinkedIn recommendations\n" 
    message << color(WHITE, 'links') << ": Links to my various profiles\n" 
    message << color(WHITE, 'help') << ": This help menu\n" 
    return message
  end

  def self.reco
    fields = ['recommendations-received']
    p = linkedin(fields)
    recoms = p[:recommendationsReceived]
    message = "\n"
    message << color(WHITE, "Recommendations Received\n")
    message << "[[;white;]" << "-" * 25 << "]\n\n"

    recoms["values"].each do |reco|
      message << word_wrap(reco["recommendationText"]) << "\n"
      message << color(ORANGE, "-") << color(ORANGE, reco["recommender"]["firstName"]) << " " << color(ORANGE, reco["recommender"]["lastName"])
    end
    
    return message
  end

  def self.links
    message = "\n"
    LINKS['main'].each do |key, link|
      message << color(ORANGE, "#{link["title"]}: ") << link["link"] << "\n"
    end
    return message
  end

  def method_missing(m, *args, &block)  
    return "type [[;white;]help], to list supported commands"
  end  

  class << self
    alias :exp :positions
    alias :experience :positions
    alias :pos :positions
    alias :edu :education
    alias :pro :projects
    alias :recommendations :reco
  end

  private
  def self.color name, msg
    "[[;#{name};]#{msg}]"
  end

  def self.linkedin fields
    basic_profile = $linkedin.get("/v1/people/~:(#{fields.join(',')})", 'x-li-format' => 'json').body 
    JSON.parse(basic_profile).symbolize_keys
  end

  def self.position_message_creater(cp, isCurrent)
    date = Proc.new {|c| "#{c['month']}/#{c['year']}" }
    message = ""
    message << "[[;orange;]#{cp['title']}] at [[;orange;]#{cp['company']['name']}], "
    message << "[[;#009D9C;]#{date.call(cp['startDate'])} - #{ isCurrent ? "present" : date.call(cp['endDate'])}]\n"
    message << "#{cp['summary'] ? word_wrap(cp['summary']) : ''}\n\n"
  end

  # taken from http://git.io/68hntw
  def self.word_wrap(text, options = {})
    line_width = options.fetch(:line_width, 100)

    text.split("\n").collect! do |line|
      line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end
end
