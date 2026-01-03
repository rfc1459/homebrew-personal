class X3270X11 < Formula
  desc "IBM 3270 terminal emulator for the X Window System and Windows"
  homepage "http://x3270.bgp.nu/"
  url "https://downloads.sourceforge.net/project/x3270/x3270/4.5ga5/suite3270-4.5ga5-src.tgz"
  sha256 "01576fa58598ccdd3d366febfaef61e3d1de93eb60a93f9ac6ba5faf84144c6f"
  license "BSD-3-Clause"

  livecheck do
    url "https://x3270.miraheze.org/wiki/Downloads"
    regex(/href=.*?suite3270[._-]v?(\d+(?:\.\d+)+(?:ga\d+)?)(?:-src)?\.t/i)
  end

  bottle do
    root_url "https://github.com/rfc1459/homebrew-personal/releases/download/x3270-x11-4.4ga6"
    sha256 arm64_sequoia: "848b7a912d7646f828b7ba528854c0588bf68a26baa2ab092b20dc321cdccde2"
    sha256 arm64_sonoma:  "cb07a1e7ba8c5c30044c8285efde0bad092785a4b01e037b37e38ec8cd36cba5"
    sha256 ventura:       "5c9f11fc8a3ec0dd63c0bf219b701966b51162dd33a08570d8e43546a2aafe3d"
    sha256 x86_64_linux:  "7088f49588e4642e182f9d2e21b172a7aa056132edea8408c161e732035c8bef"
  end

  depends_on "bdftopcf" => :build
  depends_on "mkfontscale" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "libice"
  depends_on "libx11"
  depends_on "libxaw"
  depends_on "libxext"
  depends_on "libxft"
  depends_on "libxinerama"
  depends_on "libxmu"
  depends_on "libxpm"
  depends_on "libxt"
  depends_on "openssl@3"
  depends_on "readline"

  uses_from_macos "python" => :build
  uses_from_macos "expat"
  uses_from_macos "ncurses"
  uses_from_macos "tcl-tk"

  conflicts_with "x3270", because: "x3270-x11 also provides the same binaries as x3270"

  def install
    args = %w[
      --enable-c3270
      --enable-pr3287
      --enable-s3270
      --enable-tcl3270
      --enable-x3270
    ]
    system "./configure", *args, *std_configure_args
    system "make", "install"
    system "make", "install.man"
  end

  test do
    system bin/"c3270", "--version"
  end
end
