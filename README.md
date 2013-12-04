== Wallet Diff ==
This is an app that watches your cryptocurrency wallet for changes.  It's safe.  You'll see that it doesn't call walletpassphrase at any point and even if I did, I don't know your wallet passphrase (right!?).

So what?  Sign up for prowlapp, install growl on your Mac (or Windows?) and you can get push notifications to your phone "fo free".  It's pretty goddamn nice bros.

== Run it ==
(install Ruby ... omg, I wish I knew Golang for you guys to make running this easier)

$ bundle
$ foreman start

You'll need to open up the acl on rpcallowip if you're not monitoring localhost.


=== TODO ===
I need to polish the crap out of this app and add integration tests.

Change env.example to .env