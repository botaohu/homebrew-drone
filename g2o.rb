require 'formula'

class G2o < Formula
  homepage 'https://github.com/RainerKuemmerle/g2o'
  head 'https://github.com/RainerKuemmerle/g2o.git', :using => :git

  depends_on 'cmake' => :build
  depends_on 'qt4' => :build
  depends_on 'eigen' => :build
  depends_on 'suite-sparse' => :build

  def install
    args = ["-DCMAKE_INSTALL_PREFIX=#{prefix}",
            "-DCMAKE_BUILD_TYPE=Release",
            "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON",
            "-DCMAKE_INSTALL_NAME_DIR=#{HOMEBREW_PREFIX}/lib"]
    args << '.'
    system "cmake", *args
    system "make install"
  end
end

