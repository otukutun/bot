class Dispacher
  def initialize(status)
    @status = status
  end

  def to_me?
    if @status.text.match(/(^@otukutun_bot\s)(.*)/)
      return $1
    else
      return false
    end
  end

end
