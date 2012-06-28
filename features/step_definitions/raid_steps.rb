Given /^"(.*?)" has scheduled the following raids$/ do |login, table|
  repo = Repository.for(Raid)
  current_user = Repository.for(User).find_by_login(login)

  table.hashes.each_with_index do |row, i|
    r = Raid.new(
      :id => i,
      :owner => current_user,
      :where => row[:where],
      :when => Date.parse(row[:when]),
      :start_at => Time.parse(row[:start]),
      :invite_at => Time.parse(row[:start]) - row[:invite_offset].to_i.minutes
    )

    [:tank, :heal, :dps].each do |role|
      if limit = row[role]
        r.set_role_limit role, limit.to_i
      end
    end

    repo.save r
  end
end
