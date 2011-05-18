# Slowjam

You've got slow queries. They're hiding in your app. Sing them a sweet, sweet
song with slowjam. Those slow queries will come right out.

    require 'slowjam'

    Slowjam.threshold = 300 # milliseconds
    Slowjam.frames = 5
    Slowjam.accept = %r{^(app|config|lib)}.freeze
    Slowjam.cleaner = Rails.backtrace_cleaner
    Slowjam.attach

Now when a query takes more than 300 milliseconds, it gets written to your log.
In red, so its hard to ignore.

It's really easy to grep for slow queries too:

    tail -f log/production.log|grep -A 2 'SLOW QUERY'

Go forth and find your slow queries.

## What it looks like

    SLOW QUERY
      Checkin Load (177.1ms) SELECT "checkins".* ...
      Trace: app/controllers/checkins_controller.rb:131 | app/controllers/checkins_controller.rb:120 | lib/ref.rb:294
    SLOW QUERY
      Spot Load (231.0ms) SELECT spots.* ...
      Trace: app/views/users/show_friend.json.erb:110 | app/controllers/users_controller.rb:521 | app/controllers/users_controller.rb:501 | lib/ref.rb:294

## License

Copyright 2011 Adam Keys. Slowjam is MIT licensed. 

Development sponsored by Gowalla. Go out and explore your slow queries!
