def vimfiles_dir
  File.expand_path("../vimfiles", __FILE__)
end

def command(cmd)
  if ENV["test"]
    puts(cmd)
  else
    system(cmd)
  end
end

def on_dir(dir = (ENV["dir"] || `echo ~`.strip))
  pwd = Dir.pwd
  unless File.directory?(ENV["dir"])
    Dir.mkdir(ENV["dir"])
  end
  Dir.chdir dir
  yield if block_given?
  Dir.chdir pwd
end

desc "use [dir] option to change the default \"~\" dir - configure vimfiles"
task :default => [:"link:dir", :"link:vimrc", :"link:gvimrc"]

namespace :git do

  desc "init submodules"
  task :submodules do
    command "git submodule init"
  end

  desc "update submodules"
  task :update do
    command "git submodule update"
  end

end

namespace :link do

  desc "symbolic link to .vim dir"
  task :dir => [:"git:submodules", :"git:update"] do
    on_dir do
      command "ln -s #{vimfiles_dir}/.vim .vim"
    end
  end

  desc "symbolic link to .vimrc"
  task :vimrc do
    on_dir do
      command "ln -s #{vimfiles_dir}/.vimrc .vimrc"
    end
  end

  desc "symbolic link to .gvimrc"
  task :gvimrc do
    on_dir do
      command "ln -s #{vimfiles_dir}/.gvimrc .gvimrc"
    end
  end

end

