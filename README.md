# Slowjam

You've got slow queries. They're hiding in your app. Sing them a sweet, sweet
song with slowjam. Those slow queries will come right out.

    require 'slowjam'

    Slowjam.threshold = 300 # milliseconds
    Slowjam.attach

Now when a query takes more than 300 milliseconds, it gets written to your log.
In red, so its hard to ignore.

It's really easy to grep for slow queries too:

    tail -f log/production.log|grep -A 2 'SLOW QUERY'

Go forth and find your slow queries.
