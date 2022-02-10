require "spec_helper"
require "serverspec"

package = case os[:family]
          when "redhat", "fedora"
            "vim-minimal"
          when "ubuntu"
            "vim-nox"
          when "openbsd"
            "vim"
          when "freebsd"
            "vim"
          end
additional_packages = case os[:family]
                      when "redhat", "fedora"
                        ["protobuf-vim"]
                      when "ubuntu"
                        ["vim-scripts"]
                      when "openbsd"
                        ["vim-spell-uk"]
                      when "freebsd"
                        ["shells/tcshrc"]
                      end

describe package(package) do
  it { should be_installed }
end

describe command("vim --version") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^VIM\s/) }
  its(:stderr) { should eq "" }
end

additional_packages.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end
