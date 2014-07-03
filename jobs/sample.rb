require 'github_api'

current_valuation = 0
current_karma = 0

SCHEDULER.every '2s' do
  last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = rand(100)
  current_karma     = rand(200000)
  the_time  = Time.now 
  

  send_event('valuation', { current: current_valuation, last: last_valuation })
  send_event('karma', { current: current_karma, last: last_karma })
  send_event('synergy',   { value: rand(100) })
  send_event('welcome', { title: "cara", text: "the time is #{the_time}"})


SCHEDULER.every '60s', :first_in => 0  do
    
    github = Github.new
    commit_message = github.repos.commits.all('carapark', 'Test_Dashboard').first.commit.message
    
    send_event('recent_git_commit', { text: commit_message})

end
end