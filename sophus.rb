require 'formula'

class Sophus < Formula
  homepage 'https://github.com/strasdat/Sophus'

  url "https://github.com/strasdat/Sophus.git", :using => :git, :revision => "a621ff"
  version "0.9a-double-only"

  depends_on "eigen" => :build
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
    (share/"Sophus").install "SophusConfig.cmake"
  end
end

__END__
diff --git a/sophus/so2.cpp b/sophus/so2.cpp
index 44fc4a1..6a4d32b 100644
--- a/sophus/so2.cpp
+++ b/sophus/so2.cpp
@@ -29,8 +29,7 @@ namespace Sophus

 SO2::SO2()
 {
-  unit_complex_.real() = 1.;
-  unit_complex_.imag() = 0.;
+  unit_complex_ = Complexd(1.,0.);
 }

 SO2
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8b5ee88..66b927c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -25,7 +25,7 @@ list( APPEND CMAKE_MODULE_PATH "${CMAKE_ROOT}/Modules" )
 ################################################################################
 # Create variables used for exporting in SophusConfig.cmake
 set( Sophus_LIBRARIES "" )
-set( Sophus_INCLUDE_DIR ${PROJECT_SOURCE_DIR} )
+set( Sophus_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/include )

 ################################################################################

@@ -74,8 +74,8 @@ ADD_TEST(test_sim3 test_sim3)
 ##############################################################################
 # Get full library name
 GET_TARGET_PROPERTY( FULL_LIBRARY_NAME ${PROJECT_NAME} LOCATION )
-set( Sophus_LIBRARIES ${Sophus_LIBRARIES} ${FULL_LIBRARY_NAME} )
-set( Sophus_LIBRARY_DIR ${PROJECT_BINARY_DIR} )
+set( Sophus_LIBRARIES ${Sophus_LIBRARIES} ${CMAKE_INSTALL_PREFIX}/lib/lib${PROJECT_NAME}.dylib )
+set( Sophus_LIBRARY_DIR ${CMAKE_INSTALL_PREFIX}/lib )

 ################################################################################
 # Create the SophusConfig.cmake file for other cmake projects.
@@ -84,4 +84,4 @@ CONFIGURE_FILE( ${CMAKE_CURRENT_SOURCE_DIR}/SophusConfig.cmake.in
 export( PACKAGE Sophus )

 INSTALL(DIRECTORY sophus DESTINATION ${CMAKE_INSTALL_PREFIX}/include FILES_MATCHING PATTERN "*.h" )
-INSTALL(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib )
\ No newline at end of file
+INSTALL(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib )
diff --git a/SophusConfig.cmake.in b/SophusConfig.cmake.in
index 56daf47..f61047b 100644
--- a/SophusConfig.cmake.in
+++ b/SophusConfig.cmake.in
@@ -1,12 +1,4 @@
 ################################################################################
-# Sophus source dir
-set( Sophus_SOURCE_DIR "@CMAKE_CURRENT_SOURCE_DIR@")
-
-################################################################################
-# Sophus build dir
-set( Sophus_DIR "@CMAKE_CURRENT_BINARY_DIR@")
-
-################################################################################
 set( Sophus_INCLUDE_DIR  "@Sophus_INCLUDE_DIR@" )
 set( Sophus_INCLUDE_DIRS  "@Sophus_INCLUDE_DIR@" )

