# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create! movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  # assert page.body =~ /#{e1}.+#{e2}/m
  # assert_match(/#{e1}.*#{e2}/m, page.body)
  # puts page.body
  if !page.body =~ /#{e1}.*#{e2}/m
    fail "'#{e1}' should be before '#{e2}'"
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    uncheck ? uncheck("ratings_#{rating}") : check("ratings_#{rating}")
  end
end

Then /I should see all the movies/ do
  rows = page.all('table#movies tbody tr').length
  rows.should eq Movie.count
end
