cmake_minimum_required(VERSION 3.19)
project(wmediumd LANGUAGES C)

# make cache variables for install destinations
include(GNUInstallDirs)

add_compile_definitions(VERSION_STR="0.5")

add_subdirectory(${CMAKE_SOURCE_DIR}/tests)
add_subdirectory(${CMAKE_SOURCE_DIR}/src)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)

find_package(Config REQUIRED)
find_package(Netlink REQUIRED)
find_package(Event REQUIRED)

add_executable(wmediumd
        ${WMEDIUMD_SOURCES}
        ${WMEDIUMD_HEADERS}
        )

target_link_libraries(wmediumd
        PUBLIC
        pthread
        m
        Netlink::Netlink
        Netlink::Generic
        Event::Event
        Config::Config
        )

install(TARGETS wmediumd
        DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
        )