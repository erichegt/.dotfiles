def vimfiles_dir
  File.expand_path("../", __FILE__)
end

def command(cmd)
  system(cmd)
end

def on_dir(dir = `echo ~`.strip)
  pwd = Dir.pwd
  Dir.chdir dir
  yield if block_given?
  Dir.chdir pwd
end

desc "configure vimfiles"
task :default => [:"link:dir", :"link:vimrc", :"link:gvimrc"]

namespace :link do

  desc "symbolic link to .vim dir"
  task :dir do
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

