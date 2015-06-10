require 'formula'

class Simstring < Formula
  homepage 'http://www.chokkan.org/software/simstring/'

  url "http://www.chokkan.org/software/dist/simstring-1.0.tar.gz"
  version "1.0"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end