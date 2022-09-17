set(TEST_CLIENT_SNR test_client_snr)
set(TEST_CLIENT_SNR_FILES
        ${TEST_CLIENT_SNR_FILES}
        ${CMAKE_CURRENT_SOURCE_DIR}/client_snr.c
        ${CMAKE_SOURCE_DIR}/src/wserver_messages.c
        ${CMAKE_SOURCE_DIR}/src/wserver_messages_network.c
        )

add_executable(${TEST_CLIENT_SNR}
        ${TEST_CLIENT_SNR_FILES}
        )

set(TEST_CLIENT_ERRPROB test_client_errprob)
set(TEST_CLIENT_ERRPROB_FILES
        ${TEST_CLIENT_ERRPROB_FILES}
        ${CMAKE_CURRENT_SOURCE_DIR}/client_errprob.c
        )

add_executable(${TEST_CLIENT_ERRPROB}
        ${TEST_CLIENT_ERRPROB_FILES}
        ${CMAKE_SOURCE_DIR}/src/wserver_messages.c
        ${CMAKE_SOURCE_DIR}/src/wserver_messages_network.c
        )

set(TEST_CLIENT_SPECPROB test_client_specprob)
set(TEST_CLIENT_SPECPROB_FILES
        ${TEST_CLIENT_SPECPROB_FILES}
        ${CMAKE_CURRENT_SOURCE_DIR}/client_specprob.c
        )

add_executable(${TEST_CLIENT_SPECPROB}
        ${TEST_CLIENT_SPECPROB_FILES}
        ${CMAKE_SOURCE_DIR}/src/wserver_messages.c
        ${CMAKE_SOURCE_DIR}/src/wserver_messages_network.c
        )