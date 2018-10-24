module SvnHelper
  def get_svn_file_content(path, filename, username, password, svn_url_base)
    `svn  cat #{svn_url_base}/#{path}/#{filename}  --username #{username} --password #{password} --no-auth-cache`
  end

  def delete_svn_file(path, filename, username, password, svn_url_base)
    `svn  delete #{svn_url_base}/#{path}/#{filename}  --username #{username} --password #{password} --no-auth-cache -m "delete svn file"`
  end

  def add_svn_file(path, remotefilename, localfilename, username, password, svn_url_base)
    command = "svn import -m \"add svn file\" #{localfilename}    #{svn_url_base}/#{path}/#{remotefilename} --username #{username} --password #{password} --no-auth-cache --force"
    `#{command}`
  end

  def list_svn_dir(path, username, password, svn_url_base)
    command = "svn ls  #{svn_url_base}/#{path} --username #{username} --password #{password} --no-auth-cache "
    `#{command}`
  end

  def svn_file_exist?(path, remotefilename, username, password, svn_url_base)
    command = "svn info   #{svn_url_base}/#{path}/#{remotefilename} --username #{username} --password #{password} --no-auth-cache "
    result = `#{command}`
    if result =~ /E200009/i
      false
    else
      if result.empty?
        false
      else
        true
      end
    end
  end
end
