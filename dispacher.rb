class Dispacher
  def initialize(status)
    @status = status
  end

  def to_me
    p @status[:user][:screen_name]
    username = @status[:user][:screen_name]
    return false unless username == 'otukutun'

    return $1 if @status.text.match(/(^@otukutun_bot\s)(.*)/)

    return false
  end
  
end
