class I386ElfGdb < Formula

  homepage "https://www.gnu.org/software/gdb/"
  url "http://ftpmirror.gnu.org/gdb/gdb-7.9.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gdb/gdb-7.9.1.tar.xz"
  sha256 "cd9c543a411a05b2b647dd38936034b68c2b5d6f10e0d51dc168c166c973ba40"

  def install
    args = [
      "--prefix=#{prefix}",
      "--with-gdb-datadir=#{pkgshare}",
      "--disable-werror",
      "--target=i386-elf",
    ]

    mkdir "build" do
      system "../configure", *args
      system "make"
      system "make", "install"
    end

    rm_rf include
    rm_rf lib
    rm_rf share/"locale"
    rm_rf share/"info"
  end
end
