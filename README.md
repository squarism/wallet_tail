# Wallet Tail #

Wouldn't it be nice if tail would tell you when you mined up a bitcoin?

      $ tail -f wallet.dat  # what, not even an hechicero malvado can do this

This is an app that watches your cryptocurrency wallet for changes.


## Run it ##
Install Ruby (rvm etc)

Install the dependencies

      $ bundle

Start the monitor

      $ rake monitor

You'll need to open up the acl on rpcallowip if you're not monitoring localhost.

Change env.example to .env, fill in your details like wallet url, passwords etc.

Next, sign up for prowlapp, install growl on your Mac (or Windows?) and you can get push notifications to your phone "fo free".  It's pretty goddamn nice bros and it will keep you from checking your mining rig all the time.


## Trust Issues ##

This just requires your rpc_username.  This doesn't require your wallet password.  In other words, I can't steal your money.  Check the code if you want.  Another way to look at it, if you never type your wallet password in, how can I unlock your wallet?


## TODO ##

I need to polish the crap out of this app and add integration tests.
