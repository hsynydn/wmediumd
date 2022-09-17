message("Find netlink library")

find_library(NL_GENERIC_LIBRARY_PATH NAMES libnl-genl-2.so NO_CACHE)
if (${NL_GENERIC_LIBRARY_PATH} STREQUAL NL_GENERIC_LIBRARY_PATH-NOTFOUND)
    find_library(NL_GENERIC_LIBRARY_PATH NAMES libnl-genl-3.so NO_CACHE)
endif()

if (${NL_GENERIC_LIBRARY_PATH} STREQUAL NL_GENERIC_LIBRARY_PATH-NOTFOUND)
    message(FATAL_ERROR "netlink generic library not found for version 2 and 3")
else()
    string(REGEX MATCH "(^[a-zA-Z0-9/_-]*)/libnl-genl-3.so$" NL_GENERIC_LIB_DIR ${NL_GENERIC_LIBRARY_PATH})
    set(NL_GENERIC_LIB_DIR ${CMAKE_MATCH_1} CACHE PATH '' FORCE)
    message(STATUS "netlink generic library found at ${NL_GENERIC_LIB_DIR}")
endif ()

find_library(NL_LIBRARY_PATH NAMES libnl-3.so NO_CACHE)

if (${NL_LIBRARY_PATH} STREQUAL NL_LIBRARY_PATH-NOTFOUND)
    message(FATAL_ERROR "netlink library not found")
else()
    string(REGEX MATCH "^([a-zA-Z0-9/_-]*)/libnl-3.so$" NETLINK_LIB_DIR ${NL_LIBRARY_PATH})
    set(NETLINK_LIB_DIR ${CMAKE_MATCH_1} CACHE PATH '' FORCE)
    message(STATUS "netlink library found at ${NETLINK_LIB_DIR}")
endif ()

find_file(NETLINK_HEADER_FILE_PATH NAMES netlink/netlink.h NO_CACHE HINTS /usr/include/libnl3)

if (${NETLINK_HEADER_FILE_PATH} STREQUAL NETLINK_HEADER_FILE_PATH-NOTFOUND)
    message(FATAL_ERROR "netlink header files not found")
else()
    string(REGEX MATCH "^([a-zA-Z0-9/_-]*/)netlink/netlink.h$" NETLINK_INCLUDE_DIR ${NETLINK_HEADER_FILE_PATH})
    set(NETLINK_INCLUDE_DIR ${CMAKE_MATCH_1} CACHE PATH "" FORCE)
    message(STATUS "netlink header files found at ${NETLINK_INCLUDE_DIR}")
endif ()

add_library(Netlink::Netlink SHARED IMPORTED)

set_property(TARGET Netlink::Netlink
        PROPERTY
        IMPORTED_LOCATION
        ${NL_LIBRARY_PATH}
        )

add_library(Netlink::Generic SHARED IMPORTED)

set_property(TARGET Netlink::Generic
        PROPERTY
        IMPORTED_LOCATION
        ${NL_GENERIC_LIBRARY_PATH}
        )

target_include_directories(Netlink::Netlink
        INTERFACE
        ${NETLINK_INCLUDE_DIR}
        )

target_include_directories(Netlink::Generic
        INTERFACE
        ${NETLINK_INCLUDE_DIR}
        )