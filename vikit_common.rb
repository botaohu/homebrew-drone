require 'formula'

class VikitCommon < Formula
  homepage 'https://github.com/uzh-rpg/rpg_vikit.git'

  head "https://github.com/uzh-rpg/rpg_vikit.git", :using => :git

  depends_on 'cmake' => :build

  patch :DATA

  def install
    cd "vikit_common" do
      args = ["-DCMAKE_INSTALL_PREFIX=#{prefix}",
              "-DCMAKE_BUILD_TYPE=Release",
              "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON",
              "-DCMAKE_INSTALL_NAME_DIR=#{HOMEBREW_PREFIX}/lib"]
      args << '.'
      system "cmake", *args
      system "make install"
    end
  end
end

__END__
diff --git a/vikit_common/CMakeLists.txt b/vikit_common/CMakeLists.txt
index bd3fef4..d35cd97 100644
--- a/vikit_common/CMakeLists.txt
+++ b/vikit_common/CMakeLists.txt
@@ -4,7 +4,7 @@ CMAKE_MINIMUM_REQUIRED (VERSION 2.8.3)
 SET(CMAKE_BUILD_TYPE Release) # Release, RelWithDebInfo
 SET(CMAKE_VERBOSE_MAKEFILE OFF)
 SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/CMakeModules/")
-SET(USE_ROS TRUE) # Set False if you want to build this package without Catkin
+SET(USE_ROS FALSE) # Set False if you want to build this package without Catkin

 # Set build flags. Set IS_ARM on odroid board as environment variable
 SET(CMAKE_CXX_FLAGS "-Wall -D_LINUX -D_REENTRANT -march=native -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unknown-pragmas")
@@ -94,4 +94,4 @@ IF(NOT USE_ROS)

   INSTALL(DIRECTORY include/vikit DESTINATION ${CMAKE_INSTALL_PREFIX}/include FILES_MATCHING PATTERN "*.h" )
   INSTALL(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib )
-ENDIF()
\ No newline at end of file
+ENDIF()
