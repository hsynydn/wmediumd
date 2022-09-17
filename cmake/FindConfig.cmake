message("Find libconfig library")

find_library(CONFIG_LIBRARY_PATH NAMES libconfig.so NO_CACHE)

if (${CONFIG_LIBRARY_PATH} STREQUAL CONFIG_LIBRARY_PATH-NOTFOUND)
    message(FATAL_ERROR "config library not found")
else()
    string(REGEX MATCH "^([a-zA-Z0-9/_-]*)/libconfig.so$" CONFIG_LIB_DIR ${CONFIG_LIBRARY_PATH})
    set(CONFIG_LIB_DIR ${CMAKE_MATCH_1} CACHE PATH "" FORCE)
    message(STATUS "config library found at ${CONFIG_LIB_DIR}")
endif ()

find_file(CONFIG_HEADER_FILE_PATH NAMES libconfig.h NO_CACHE)

if (${CONFIG_HEADER_FILE_PATH} STREQUAL CONFIG_HEADER_FILE_PATH-NOTFOUND)
    message(FATAL_ERROR "config header files not found")
else()
    string(REGEX MATCH "^([a-zA-Z0-9/_-]*)/libconfig.h$" CONFIG_INCLUDE_DIR ${CONFIG_HEADER_FILE_PATH})
    set(CONFIG_INCLUDE_DIR ${CMAKE_MATCH_1} CACHE PATH "" FORCE)
    message(STATUS "config header files found at ${CONFIG_INCLUDE_DIR}")
endif ()

add_library(Config::Config SHARED IMPORTED)

set_property(TARGET Config::Config
        PROPERTY
        IMPORTED_LOCATION ${CONFIG_LIBRARY_PATH}
        )

target_include_directories(Config::Config
        INTERFACE
        ${CONFIG_INCLUDE_DIR}
        )