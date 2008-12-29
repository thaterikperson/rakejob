class RakeJob

  def self.find_rake
    rake = %x{which rake}
    if rake.nil? or rake.empty?
      raise RakeNotInstalledException
    end
    rake.chomp
  end

  def initialize(task, args = {})
    @@rake ||= RakeJob.find_rake
    @task = task
    @args = args
  end

  def run!
    parameters = ''
    @args.each do |name, value|
      parameters += "#{name}=#{value} "
    end
    command = "cd #{RAILS_ROOT} && #{@@rake} RAILS_ENV=#{ENV['RAILS_ENV']} #{@task} #{parameters}"
    unless (system command)
    	raise RakeTaskNotFoundError.new(command)
    end
  end
end

class RakeTaskNotFoundError < StandardError
end

class RakeNotInstalledError < StandardError
end
