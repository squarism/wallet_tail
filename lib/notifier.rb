require 'growl'

class Notifier

  def priority
    "Emergency"
  end

  def annoy message
    Growl.notify message, title: 'Wallet Diff At Your Service', priority: priority
  end

end