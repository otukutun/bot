class Dispacher
  def initialize(status)
    @status = status
  end

  def to_me?
    if @status.text.match(/(^@otukutun_bot\s)(.*)/)
      return true
    else
      return false
    end
  end

  def get_tweet
    if md = @status.text.match(/(^@otukutun_bot\s)(.*)/)
      return md[2]
    end
  end

end
