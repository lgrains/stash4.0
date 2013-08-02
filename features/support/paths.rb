
def path_to(page_name)
  case page_name

  when /the home\s?page/
    '/home'
  when /the signup page/
    '/signup'
  end
end