require 'formula'

class Libdap < Formula
  homepage 'http://www.opendap.org'
  url 'http://www.opendap.org/pub/source/libdap-3.11.5.tar.gz'
  sha1 '08ca4d3b9c517a9e9cc3f245678144361e357f5c'

  depends_on 'pkg-config' => :build

  def install
    # NOTE:
    # To future maintainers: if you ever want to build this library as a
    # universal binary, see William Kyngesburye's notes:
    #     http://www.kyngchaos.com/macosx/build/dap
    system "./configure",
           "--disable-debug",
           "--disable-dependency-tracking",
           "--prefix=#{prefix}",
           # __Always pass the curl prefix!__
           # Otherwise, configure will fall back to pkg-config and on Leopard
           # and Snow Leopard, the libcurl.pc file that ships with the system
           # is seriously broken---too many arch flags. This will be carried
           # over to `dap-config` and from there the contamination will spread.
           "--with-curl=/usr",
           "--with-included-regex"

    system "make install"
  end
end
