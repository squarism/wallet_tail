require 'growl'

class Notifier

  def priority
    "Emergency"
  end

  def annoy message
    Growl.notify message, title: 'Wallet Tail Event', priority: priority
  end

end