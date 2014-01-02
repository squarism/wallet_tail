## Wallet Diff ##
![image](https://raw.github.com/squarism/wallet_tail/master/img/overview.png)

This is an app that watches your cryptocurrency wallet for changes.  It's safe.  You'll see that it doesn't call walletpassphrase at any point and even if I did, I don't know your wallet passphrase (right!?).

So what?  Sign up for prowlapp, install growl on your Mac (or Windows?) and you can get push notifications to your phone "fo free".  It's pretty goddamn nice bros.

## Wire Up Your Wallets ##
1. Edit conf/foocoin.conf.example as described within the file
2. Save it as a new file called foocoin.conf if you wanted to watch your foocoin wallet
3. You would create one file under conf for each wallet you want to watch.  If you only have one wallet, then just create one file.

       For example:
         litecoin.conf --> your litecoin wallet that's solo mining
         namecoin.conf --> your namecoin wallet that's solo mining

4. Then run `$ rake monitor foocoin`


## Run it ##
(install Ruby ... omg, I wish I knew Golang for you guys to make running this easier)

    $ bundle
    $ rake monitor feathercoin

You'll need to open up the acl on rpcallowip if you're not monitoring localhost.


If you have just one wallet to watch then you can just run `rake monitor` (after creating the conf/whatever.conf profile for the single wallet you want to watch).


### TODO ###

- Add integration tests.
- Be rad.
