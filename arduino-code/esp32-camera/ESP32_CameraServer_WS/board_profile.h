#ifndef BOARD_PROFILE_H
#define BOARD_PROFILE_H

#if defined(CONFIG_IDF_TARGET_ESP32S3)
#define CAR_BOARD_PROFILE_LABEL "ESP32-S3"
#define CAR_UART_RX_PIN 3
#define CAR_UART_TX_PIN 40
#elif defined(CONFIG_IDF_TARGET_ESP32)
#define CAR_BOARD_PROFILE_LABEL "ESP32-WROVER"
#define CAR_UART_RX_PIN 33
#define CAR_UART_TX_PIN 4
#else
#error "Unsupported ESP32 target for this firmware"
#endif

#endif
