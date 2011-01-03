Before do
  Time.zone = "Central Time (US & Canada)"
end

After do
  Timecop.return
end
