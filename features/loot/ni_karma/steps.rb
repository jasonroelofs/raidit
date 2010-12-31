Then "I should see the following karma values" do |table|
  table.hashes.each do |row|
    character = Character.find_by_name(row[:character])
    within(:css, "tr#karma_#{character.name}") do
      page.should have_css("td", :text => row[:character])
      page.should have_css("td.current", :text => row[:current])
      page.should have_css("td.lifetime", :text => row[:lifetime])
    end
  end
end

Then "there are the following history entries" do |table|
  table.hashes.each do |row|
    character = Character.find_by_name(row[:character])
    character.loot_history_entries.count.should == row[:count].to_i
  end
end
