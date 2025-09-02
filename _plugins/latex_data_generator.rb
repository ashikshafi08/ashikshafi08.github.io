Jekyll::Hooks.register :site, :after_init do |site|
  # Parse the resume.tex file and generate data
  resume_path = File.join(site.source, 'resume.tex')
  
  if File.exist?(resume_path)
    parsed_data = Jekyll::LatexParser.parse_resume(resume_path)
    
    # Store the parsed data in site.data
    site.data['latex_resume'] = parsed_data
    
    Jekyll.logger.info "LatexParser:", "Successfully parsed resume.tex"
  else
    Jekyll.logger.warn "LatexParser:", "resume.tex not found at #{resume_path}"
  end
end