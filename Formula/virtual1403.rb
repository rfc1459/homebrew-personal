class Virtual1403 < Formula
  desc "Emulate an IBM 1403 printer for use with Hercules"
  homepage "https://github.com/racingmars/virtual1403"
  url "https://github.com/racingmars/virtual1403/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "35b2d0b0e46c2256fb498d431a6836f5c77b6b94fe9fd2b1cf887298f0b57d6a"
  license "GPL-3.0-or-later"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "github.com/racingmars/virtual1403/agent"
    doc.install "COPYING", "agent/README", "agent/config.sample.yaml"
  end

  def caveats
    <<~EOS
      #{name} requires a config.yaml file in the current working directory.

      You can find an example at #{doc}/config.sample.yaml.
    EOS
  end

  test do
    system bin/"virtual1403", "--version"
  end
end
