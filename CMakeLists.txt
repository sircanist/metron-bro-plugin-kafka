cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(PRO_VERSION "0.4")
project(Plugin)

include(ZeekPlugin)
find_package(LibRDKafka)
find_package(OpenSSL)

if (LIBRDKAFKA_FOUND AND OPENSSL_FOUND)
  include_directories(BEFORE ${LibRDKafka_INCLUDE_DIR} ${OpenSSL_INCLUDE_DIR})
  zeek_plugin_begin(APACHE KAFKA)
  zeek_plugin_cc(src/KafkaWriter.cc)
  zeek_plugin_cc(src/Plugin.cc)
  zeek_plugin_cc(src/TaggedJSON.cc)
  zeek_plugin_bif(src/kafka.bif)
  zeek_plugin_bif(src/events.bif)
  zeek_plugin_dist_files(README CHANGES COPYING VERSION)
  zeek_plugin_link_library(${LibRDKafka_LIBRARIES})
  zeek_plugin_link_library(${LibRDKafka_C_LIBRARIES})
  zeek_plugin_link_library(${OpenSSL_LIBRARIES})
  zeek_plugin_end()

  file(STRINGS "${CMAKE_CURRENT_SOURCE_DIR}/VERSION" VERSION LIMIT_COUNT 1)

  if ("${PROJECT_SOURCE_DIR}" STREQUAL "${CMAKE_SOURCE_DIR}")
      # Allows building rpm/deb packages via "make package" in build dir.
      include(ConfigurePackaging)
      ConfigurePackaging(${PRO_VERSION})
  endif ()

elseif (NOT LIBRDKAFKA_FOUND)
  message(FATAL_ERROR "LibRDKafka not found.")

elseif (NOT OPENSSL_FOUND)
  message(FATAL_ERROR "OpenSSL not found.")


endif ()
