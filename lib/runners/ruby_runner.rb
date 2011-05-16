module Runners
  class RubyRunner
    def run(script)
      `ruby -e "#{script}"`
    end
  end
end