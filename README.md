## Wallet Tail ##
![image](https://raw.github.com/squarism/wallet_tail/master/img/overview.png)

Wouldn't it be nice if tail would tell you when you mined up a bitcoin?


## Wire Up Your Wallets ##
1. Edit conf/foocoin.conf.example as described within the file
2. Save it as a new file called foocoin.conf if you wanted to watch your foocoin wallet
3. You would create one file under conf for each wallet you want to watch.  If you only have one wallet, then just create one file.

       For example:
         litecoin.conf --> your litecoin wallet that's solo mining
         namecoin.conf --> your namecoin wallet that's solo mining


## Run it ##
You'll need Ruby installed (rvm etc).  On Windows, use railsinstaller.

Install the dependencies.

    $ bundle

Start the monitor.

    $ rake monitor foocoin


On your client, you'll need to open up the acl on rpcallowip if you're not monitoring localhost.  In other words, if you are monitoring from one computer to the wallet on another computer.

Next, sign up for prowlapp, install growl on your Mac (or Windows?) and you can get push notifications to your phone "fo free". It's pretty goddamn nice bros and it will keep you from checking your mining rig all the time.


## Tips ##

If you have just one wallet to watch then you can just run `rake monitor` (after creating the conf/whatever.conf profile for the single wallet you want to watch).


### TODO ###

- Add integration tests.
- Be rad.
