# E-Z I2C Adapter & USB-UART Bridge

This project transforms a Raspberry Pi Pico into a multi-function hardware debugging tool. It provides a concurrent **I2C Master** and a **USB-to-UART Bridge** over a single USB connection, allowing you to control and monitor hardware directly from your PC.

The device enumerates as two separate COM ports:
1.  **First Port (CDC 0):** EZ-I2C Adapter
2.  **Second Port (CDC 1):** EZ-UART Bridge

---

## Hardware Pinout

| Function | Pi Pico Pin | GPIO | Notes |
| :--- | :--- | :--- | :--- |
| **I2C SDA** | Pin 19 | GPIO 14 | Requires external pull-up (e.g. 6.8k) to 3.3V |
| **I2C SCL** | Pin 20 | GPIO 15 | Requires external pull-up (e.g. 6.8k) to 3.3V |
| **UART TX** | Pin 1 | GPIO 0 | Pico Transmit / Target Receive |
| **UART RX** | Pin 2 | GPIO 1 | Pico Receive / Target Transmit |
| **Ground** | Pin 3, 8, etc. | GND | Common Ground |
| **3.3V Out**| Pin 36 | 3V3 | For pull-ups or low-power targets |

---

## 1. I2C Adapter Function

The I2C interface supports interactive text commands via a serial terminal or automated control via Python. It is backward-compatible with the [original Easy Pico Adapter](https://github.com/shabaz123/easy_pico_adapter).

### Interactive Terminal Usage
Connect to the **first COM port** (Port 1) at any baud rate. Commands are space-separated ASCII.

**Example: Write 0xAA to device at address 0x0B**
```text
addr:0x0b
bytes:1
send AA
```
For more examples, refer to the [original project](https://github.com/shabaz123/easy_pico_adapter).

### Python API
You can use the existing `easyadapter.py` library from the [original project](https://github.com/shabaz123/easy_pico_adapter). Simply point the library to the COM port associated with the "EZ-I2C Adapter".

---

## 2. USB-UART Bridge Function

Connect to the second COM port. This port acts as a transparent bridge to the hardware UART on GPIO 0/1.

- **Dynamic Baud Rate:** The hardware UART baud rate automatically updates when you change the settings in your PC terminal software (e.g., PuTTY, Tera Term).

---

## Building from Source

A build script is provided for Windows users using the ARM GNU Toolchain and Ninja.

1.  Ensure the paths in `build.ps1` match your environment.
2.  Run `build.bat`.
3.  Flash the resulting `build/ez_i2c_adapter_and_uart_bridge.uf2` to your Pico.

It is possible to build the code on Linux, Mac, and using VS Code and other IDEs, but you may need to make slight tweaks to CMakeLists.txt.

---

## Credits
Based on [easy_pico_adapter](https://github.com/shabaz123/easy_pico_adapter)
