###############################################
## Command Line Interface
###############################################

set(startercli_SRCS
    main.cpp
)

find_package( OpenCV REQUIRED )

add_executable(startercli
    ${startercli_SRCS}
)
set_target_properties(startercli PROPERTIES
    OUTPUT_NAME starter
)
target_link_libraries(startercli
    ${OpenCV_LIBS}
)
install(TARGETS startercli DESTINATION bin)
