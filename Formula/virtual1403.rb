class Virtual1403 < Formula
  desc "Emulate an IBM 1403 printer for use with Hercules"
  homepage "https://github.com/racingmars/virtual1403"
  url "https://github.com/racingmars/virtual1403/archive/refs/tags/v0.5.5.tar.gz"
  sha256 "03147dfb8597d89ddeb70f1fc5cb7184a91e67a92ac7a99ac5019ff375d759f3"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/rfc1459/homebrew-personal/releases/download/virtual1403-0.5.5"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f50f47b0277228a67e48959c0e100bbc8777b0d99a1291867face66a0cafe145"
  end

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
