

class RakeJob

  def self.find_rake
    rake = %x{which rake}
    if rake.nil? or rake.empty?
      raise RakeNotInstalledException
    end
    rake.chomp
  end

  def initialize(task)
    @@rake ||= RakeJob.find_rake
    @task = task
  end

  def run!
    command = "cd #{RAILS_ROOT} && #{@@rake} #{@task}"
    system command
  end
end

class RakeNotInstalledException < StandardError
end
