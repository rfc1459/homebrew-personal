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
    root_url "https://github.com/rfc1459/homebrew-personal/releases/download/x3270-x11-4.5ga5"
    sha256 arm64_tahoe:   "6d331968711adcb33575c78f34bdad41c2f3c03dbcafcf70eb0f196289fc8989"
    sha256 arm64_sequoia: "3a2f9120b3ec10314cb1d4abc73caded0e111f2755ec007b9a56726d570f1c9c"
    sha256 arm64_sonoma:  "94107798c2d0e145ee2246a0ad515acf33961f05535c622cb375fcbb799fd4d5"
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
