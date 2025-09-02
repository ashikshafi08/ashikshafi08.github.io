module Jekyll
  class LatexParser
    def self.parse_resume(file_path)
      content = File.read(file_path)
      
      # Extract header information
      header = extract_header(content)
      
      # Extract sections
      sections = extract_sections(content)
      
      {
        'header' => header,
        'sections' => sections
      }
    rescue => e
      Jekyll.logger.error "LatexParser:", "Error parsing #{file_path}: #{e.message}"
      {}
    end
    
    private
    
    def self.extract_header(content)
      # Extract name and contact info from tabular environment
      tabular_match = content.match(/\\begin\{tabular\*\}\{\\textwidth\}\{l@\{\\extracolsep\{\\fill\}\}r\}(.*?)\\end\{tabular\*\}/m)
      return {} unless tabular_match
      
      lines = tabular_match[1].strip.split('\\\\')
      
      # Parse first line - name and email
      first_line = lines[0].strip
      name_match = first_line.match(/\\textbf\{\\href\{[^}]+\}\{\\Large ([^}]+)\}\}/)
      email_match = first_line.match(/Email: \\href\{mailto:([^}]+)\}\{[^}]+\}/)
      
      # Parse second line - title and phone
      second_line = lines[1]&.strip || ''
      title_match = second_line.match(/\\small ([^&]+) &/)
      phone_match = second_line.match(/Mobile: (.+)/)
      
      {
        'name' => name_match ? name_match[1].strip : '',
        'title' => title_match ? title_match[1].gsub('\\,|\\,', ' | ').strip : '',
        'email' => email_match ? email_match[1].strip : '',
        'phone' => phone_match ? phone_match[1].strip : ''
      }
    end
    
    def self.extract_sections(content)
      sections = []
      
      # Find all section definitions
      section_matches = content.scan(/\\section\{([^}]+)\}(.*?)(?=\\section\{|\\end\{document\})/m)
      
      section_matches.each do |section_name, section_content|
        case section_name.downcase
        when 'summary'
          sections << parse_summary_section(section_name, section_content)
        when 'experience'
          sections << parse_experience_section(section_name, section_content)
        when 'technical skills'
          sections << parse_skills_section(section_name, section_content)
        when 'education'
          sections << parse_education_section(section_name, section_content)
        when 'projects'
          sections << parse_projects_section(section_name, section_content)
        end
      end
      
      sections
    end
    
    def self.parse_summary_section(name, content)
      # Extract summary text, clean up LaTeX commands
      summary = content.gsub(/\\[a-zA-Z]+\{([^}]*)\}/, '\1')
                      .gsub(/\\&/, '&')
                      .gsub(/\\\$/, '$')
                      .gsub(/\\%/, '%')
                      .gsub(/\$\\times\$/, '×')
                      .strip
      
      {
        'title' => name,
        'type' => 'summary',
        'content' => summary
      }
    end
    
    def self.parse_experience_section(name, content)
      jobs = []
      
      # Find all resumeSubheading entries
      job_matches = content.scan(/\\resumeSubheading\s*\{([^}]+)\}\{([^}]+)\}\s*\{([^}]+)\}\{([^}]+)\}(.*?)(?=\\resumeSubheading|\\resumeSubHeadingListEnd)/m)
      
      job_matches.each do |title, dates, company, location, job_content|
        # Extract bullet points
        bullets = []
        bullet_matches = job_content.scan(/\\resumeItem\{(.*?)\}/)
        
        bullet_matches.each do |bullet_content|
          # Clean up LaTeX formatting
          clean_bullet = bullet_content[0].gsub(/\\textbf\{([^}]+)\}/, '<strong>\1</strong>')
                                          .gsub(/\\textit\{([^}]+)\}/, '<em>\1</em>')
                                          .gsub(/\\textasciitilde/, '~')
                                          .gsub(/\\%/, '%')
                                          .gsub(/\\\$/, '$')
                                          .gsub(/\\&/, '&')
                                          .strip
          
          bullets << clean_bullet unless clean_bullet.empty?
        end
        
        jobs << {
          'title' => title.strip,
          'dates' => dates.strip,
          'company' => company.strip,
          'location' => location.strip,
          'bullets' => bullets
        }
      end
      
      {
        'title' => name,
        'type' => 'experience',
        'jobs' => jobs
      }
    end
    
    def self.parse_skills_section(name, content)
      skills = {}
      
      # Extract skill categories from itemize environment
      skill_matches = content.scan(/\\textbf\{([^}]+)\}\{:\s*([^}\\]+)/)
      
      skill_matches.each do |category, skills_list|
        clean_category = category.gsub(/\s*\\&\s*/, ' & ').strip
        clean_skills = skills_list.strip.chomp(' \\\\').strip
        skills[clean_category] = clean_skills
      end
      
      {
        'title' => name,
        'type' => 'skills',
        'skills' => skills
      }
    end
    
    def self.parse_education_section(name, content)
      schools = []
      
      # Find all resumeSubheading entries for education
      edu_matches = content.scan(/\\resumeSubheading\s*\{([^}]+)\}\{([^}]+)\}\s*\{([^}]+)\}\{([^}]+)\}/)
      
      edu_matches.each do |school, dates, degree, location|
        schools << {
          'school' => school.strip,
          'dates' => dates.strip,
          'degree' => degree.strip,
          'location' => location.strip
        }
      end
      
      {
        'title' => name,
        'type' => 'education',
        'schools' => schools
      }
    end
    
    def self.parse_projects_section(name, content)
      projects = []
      
      # Find all resumeProjectHeading entries
      project_matches = content.scan(/\\resumeProjectHeading\s*\{([^}]+)\}\{\}(.*?)(?=\\resumeProjectHeading|\\resumeSubHeadingListEnd)/m)
      
      project_matches.each do |title_line, project_content|
        # Extract project title and GitHub link
        title_match = title_line.match(/\\textbf\{([^}]+)\}/)
        github_match = title_line.match(/\\href\{([^}]+)\}\{\\texttt\{\[GitHub\]\}\}/)
        
        # Extract bullet points
        bullets = []
        bullet_matches = project_content.scan(/\\resumeItem\{(.*?)\}/)
        
        bullet_matches.each do |bullet_content|
          clean_bullet = bullet_content[0].gsub(/\\textbf\{([^}]+)\}/, '<strong>\1</strong>')
                                          .gsub(/\\,/, '')
                                          .gsub(/\\\$/, '$')
                                          .strip
          
          bullets << clean_bullet unless clean_bullet.empty?
        end
        
        projects << {
          'title' => title_match ? title_match[1].strip : '',
          'github_url' => github_match ? github_match[1].strip : '',
          'bullets' => bullets
        }
      end
      
      {
        'title' => name,
        'type' => 'projects',
        'projects' => projects
      }
    end
  end
end