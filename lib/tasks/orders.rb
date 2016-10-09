namespace :orders do

  # Has to be scheduled before midnight
  task :expire do
    # no specification on what to do with orders after the day is over!
    Order.current.where(state: :active).update_all(state: :finalized)
  end

end
