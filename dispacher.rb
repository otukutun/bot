class Dispacher
  def initialize(status)
    @status = status
  end

  def to_me?
    return $1 if @status.text.match(/(^@otukutun_bot\s)(.*)/)
    return false
  end
  
end
