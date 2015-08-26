class I386ElfGcc < Formula

  desc "GNU compiler collection for i386-elf development"
  homepage "https://gcc.gnu.org"
  url "http://ftpmirror.gnu.org/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2"
  sha256 "5f835b04b5f7dd4f4d2dc96190ec1621b8d89f2dc6f638f9f8bc1b1014ba8cad"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "i386-elf-binutils"

  def install
    languages = %w[c]

    binutils = Formula.factory "i386-elf-binutils"

    args = [
      "--prefix=#{prefix}",
      "--enable-languages=#{languages.join(",")}",
      "--disable-werror",
      "--disable-nls",
      "--disable-libssp",
      "--disable-libmudflap",
      "--disable-multilib",
      "--with-as=#{binutils.bin}/i386-elf-as",
      "--with-ld=#{binutils.bin}/i386-elf-ld",
      "--with-newlib",
      "--without-headers",
      "--target=i386-elf"
    ]

    mkdir "build" do
      system "../configure", *args
      system "make", "all-gcc"
      system "make", "install-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-target-libgcc"
    end

    # Rename man7
    Dir.glob(man7/"*.7") { |file| add_prefix file, i386-elf }

    info.rmtree
  end

  def add_prefix(file, prefix)
    dir = File.dirname(file)
    ext = File.extname(file)
    base = File.basename(file, ext)
    File.rename file, "#{dir}/#{prefix}-#{base}#{ext}"
  end

end
