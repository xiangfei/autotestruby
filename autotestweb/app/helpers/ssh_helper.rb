module SshHelper
  def run(host, username, password, port, cmd, &block)
    Net::SSH.start(host, username, :password => password, :port => port) do |ssh|
      channel = ssh.open_channel do |ch|
        ch.exec cmd do |ch, success|
          raise "could not execute command #{cmd}" unless success

          ch.on_data do |c, data|
            $stdout.print data
            block.call data if block_given?
          end

          ch.on_extended_data do |c, type, data|
            $stderr.print data
            block.call data if block_given?
          end

          ch.on_close { puts "done!" }
        end
      end

      channel.wait
    end
  end

  def copyfile(host, username, password, port, sourcefile, destfile)
    Net::SFTP.start(host, username, :password => password, :port => port) do |sftp|
      sftp.download!(sourcefile, destfile)
    end
  end
end
