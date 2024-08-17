Rails.application.routes.draw do
  root 'welcome#index'
  get "play_now", to: "matchmaking#play_now"
  get "games", to: "games#index"
  post "execute_code", to: "games#execute_code"
  post "challenge_friend", to: "matchmaking#challenge_friend"
  post "find_opponent", to: "matchmaking#find_opponent"
end
