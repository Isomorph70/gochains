require 'rufus-scheduler'

# take a cron file on stdin and execute the commands

def execute_tasks(starttime)
  now=Time.now
  starttime=Time.at(now.to_i-24*60*60) if starttime.nil? 
  $stdin.each_line do |line|
    md= /^([^\t|^\#].*\t){5}/.match(line)
    if (md)
      cron = Rufus::Scheduler::CronLine.new(md[0]) 
      next_time = cron.next_time(starttime)
      if (next_time.day()==now.day())
        command=line[md[0].length .. line.length-1]
        system(command)
      end
    end
  end
end

execute_tasks(nil)
