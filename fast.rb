require 'formula'

class Fast < Formula
  homepage 'https://github.com/uzh-rpg/fast'

  head "https://github.com/uzh-rpg/fast.git", :using => :git

  depends_on 'cmake' => :build

  patch :DATA

  def install
    args = ["-DCMAKE_INSTALL_PREFIX=#{prefix}",
            "-DCMAKE_BUILD_TYPE=Release",
            "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON",
            "-DCMAKE_INSTALL_NAME_DIR=#{HOMEBREW_PREFIX}/lib"]
    args << '.'
    system "cmake", *args
    system "make install"
    (share/"fast").install "fastConfig.cmake"
  end
end
__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8967c95..9ca18db 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -20,7 +20,7 @@ SET(CMAKE_VERBOSE_MAKEFILE ON)

 # Build type and flags
 SET(CMAKE_BUILD_TYPE Release) # Options:  Debug, RelWithDebInfo, Release
-SET(CMAKE_CXX_FLAGS "-Wall -Werror -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unknown-pragmas")
+SET(CMAKE_CXX_FLAGS "-Wall -Werror -Wno-unused-variable -Wno-unknown-pragmas")
 SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} -O0 -g")
 IF(IS_ARM)
   SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -O3 -mfpu=neon -march=armv7-a")
@@ -54,10 +54,10 @@ ENDIF()

 ################################################################################
 # Create the fastConfig.cmake file for other cmake projects.
-GET_TARGET_PROPERTY( FULL_LIBRARY_NAME ${PROJECT_NAME} LOCATION )
-SET(fast_LIBRARIES ${FULL_LIBRARY_NAME} )
-SET(fast_LIBRARY_DIR ${PROJECT_BINARY_DIR} )
-SET(fast_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/include")
+GET_TARGET_PROPERTY( FULL_LIBRARY_NAME ${PROJECT_NAME}  LOCATION)
+SET(fast_LIBRARY_DIR ${CMAKE_INSTALL_PREFIX}/lib )
+SET(fast_LIBRARIES ${fast_LIBRARY_DIR}/lib${PROJECT_NAME}.dylib )
+SET(fast_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/include)
 CONFIGURE_FILE( ${CMAKE_CURRENT_SOURCE_DIR}/fastConfig.cmake.in
     ${CMAKE_CURRENT_BINARY_DIR}/fastConfig.cmake @ONLY IMMEDIATE )
 export( PACKAGE fast )
diff --git a/fastConfig.cmake.in b/fastConfig.cmake.in
index 6c842cb..6346964 100644
--- a/fastConfig.cmake.in
+++ b/fastConfig.cmake.in
@@ -1,12 +1,3 @@
-#######################################################
-# Fast source dir
-set( fast_SOURCE_DIR "@CMAKE_CURRENT_SOURCE_DIR@")
-
-#######################################################
-# Fast build dir
-set( fast_DIR "@CMAKE_CURRENT_BINARY_DIR@")
-
-#######################################################
 set( fast_INCLUDE_DIR  "@fast_INCLUDE_DIR@" )
 set( fast_INCLUDE_DIRS "@fast_INCLUDE_DIR@" )
