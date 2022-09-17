message("Find libevent library")

find_library(EVENT_LIBRARY_PATH NAMES libevent.so NO_CACHE)

if (${EVENT_LIBRARY_PATH} STREQUAL EVENT_LIBRARY_PATH-NOTFOUND)
    message(FATAL_ERROR "event library not found")
else()
    string(REGEX MATCH "^([a-zA-Z0-9/_-]*)/libevent.so$" EVENT_LIB_DIR ${EVENT_LIBRARY_PATH})
    set(EVENT_LIB_DIR ${CMAKE_MATCH_1} CACHE PATH "" FORCE)
    message(STATUS "event library found at ${EVENT_LIB_DIR}")
endif ()

find_file(EVENT_HEADER_FILE_PATH NAMES event2/event.h NO_CACHE)

if (${EVENT_HEADER_FILE_PATH} STREQUAL EVENT_HEADER_FILE_PATH-NOTFOUND)
    message(FATAL_ERROR "event header files not found")
else()
    string(REGEX MATCH "^([a-zA-Z0-9/_-]*)/event2/event.h$" EVENT_INCLUDE_DIR ${EVENT_HEADER_FILE_PATH})
    set(EVENT_INCLUDE_DIR ${CMAKE_MATCH_1} CACHE PATH "" FORCE)
    message(STATUS "event header files found at ${EVENT_INCLUDE_DIR}")
endif ()

add_library(Event::Event SHARED IMPORTED)

set_property(TARGET Event::Event
        PROPERTY
        IMPORTED_LOCATION ${EVENT_LIBRARY_PATH}
        )

target_include_directories(Event::Event
        INTERFACE
        ${EVENT_INCLUDE_DIR}
        )