cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)

set(projname "ez_i2c_adapter_and_uart_bridge")
project(${projname})

pico_sdk_init()

if (TARGET tinyusb_device)
        add_executable(${projname}
        main.c
        extrafunc.c
        usb_descriptors.c
        )

        target_include_directories(${projname} PRIVATE ${CMAKE_CURRENT_LIST_DIR})

        target_link_libraries(${projname}
                pico_stdlib
                hardware_i2c
                hardware_uart
                tinyusb_device
                pico_stdio
                pico_unique_id
                )

        # adjust to enable stdio via usb, or uart
        pico_enable_stdio_usb(${projname} 0)
        pico_enable_stdio_uart(${projname} 0)

        pico_add_extra_outputs(${projname})
elseif(PICO_ON_DEVICE)
        message("Skipping build because TinyUSB submodule is not initialized in the SDK")
endif()

