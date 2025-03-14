class X3270X11 < Formula
  desc "IBM 3270 terminal emulator for the X Window System and Windows"
  homepage "http://x3270.bgp.nu/"
  url "http://x3270.bgp.nu/download/04.04/suite3270-4.4ga5-src.tgz"
  sha256 "bbee5a36c68f7818c1efb12fadc9ad5c0b7936134343fd6454722697aa2e0b3b"
  license "BSD-3-Clause"

  livecheck do
    url "https://x3270.miraheze.org/wiki/Downloads"
    regex(/href=.*?suite3270[._-]v?(\d+(?:\.\d+)+(?:ga\d+)?)(?:-src)?\.t/i)
  end

  bottle do
    root_url "https://github.com/rfc1459/homebrew-personal/releases/download/x3270-x11-4.4ga5"
    rebuild 1
    sha256 arm64_sequoia: "7e60bfe7d06aa65bc5eca1fd789f5209a38acd6854aeae7afffb806dfa6356aa"
    sha256 arm64_sonoma:  "e832bbb13f878f7331af6ec15c22166b3afbde2f6443be72174e27c59d18a2e3"
    sha256 ventura:       "f4126a0db2feadd69ecd539a5909f9160daffe12aa986b335609dba0a1c5694f"
    sha256 x86_64_linux:  "f97f32a0e6dfeba393b36f02f2a22727c7c706e0dd54e8ba77b3b3e3a020eda8"
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
  uses_from_macos "ncurses"

  on_linux do
    depends_on "tcl-tk@8"
  end

  conflicts_with "x3270", because: "x3270-x11 also provides the same binaries as x3270"

  def install
    # Fix to read SOURCE_DATE_EPOCH as an unix timestamp not a date string
    inreplace "Common/mkversion.py", "strptime(os.environ['SOURCE_DATE_EPOCH'], '%a %b %d %H:%M:%S %Z %Y')",
                                     "fromtimestamp(int(os.environ['SOURCE_DATE_EPOCH']))"
    ENV.append "CPPFLAGS", "-I#{Formula["tcl-tk@8"].opt_include}/tcl-tk" if OS.linux?

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
