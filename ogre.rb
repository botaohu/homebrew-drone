require 'formula'

class Ogre < Formula
  homepage 'http://www.ogre3d.org/'
  url 'https://downloads.sourceforge.net/project/ogre/ogre/1.8/1.8.1/ogre_src_v1-8-1.tar.bz2'
  version '1.8.1'
  sha1 'd6153cacda24361a81e7d0a6bf9aa641ad9dd650'
  head 'https://bitbucket.org/sinbad/ogre', :branch => 'v1-9', :using => :hg

  depends_on 'boost'
  depends_on 'cmake' => :build
  depends_on 'doxygen'
  depends_on 'freeimage'
  depends_on 'freetype'
  depends_on 'libzzip'
  depends_on 'tbb'
  depends_on :x11

  option 'with-cg'

  patch do
    url 'https://gist.githubusercontent.com/botaohu/e9a9d041aaaa78ea5ed3/raw/0beb629a36b04d30da989d67cf6f784f5f13518d/fix.patch'
  end

  def install
    ENV.m64

    cmake_args = [
      "-DCMAKE_OSX_ARCHITECTURES='x86_64'",
    ]
    cmake_args << "-DOGRE_BUILD_PLUGIN_CG=OFF" if build.without? "cg"
    cmake_args.concat(std_cmake_args)
    cmake_args << ".."

    mkdir "build" do
      system "cmake", *cmake_args
      system "make install"
    end
  end
end

