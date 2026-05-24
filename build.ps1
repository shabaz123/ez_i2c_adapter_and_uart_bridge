# Build script for Easy I2C & UART Adapter

# 1. Setup Paths (from GEMINI.md)
$PICO_SDK_PATH = "C:\DEV\projects\pico\pico-sdk"
$PICO_EXTRAS_PATH = "C:\DEV\projects\pico\pico-extras"
$TOOLCHAIN_BIN = "C:\DEV\projects\pico\arm_gnu_toolchain\bin"
$NINJA_BIN = "C:\DEV\vhd_mounts\clion\CLion 2025.3.3\bin\ninja\win\x64"
$CMAKE_BIN = "C:\DEV\vhd_mounts\clion\CLion 2025.3.3\bin\cmake\win\x64\bin"
$MINGW_BIN = "C:\DEV\vhd_mounts\clion\CLion 2025.3.3\bin\mingw\bin"

# 2. Set Environment Variables
$env:PICO_SDK_PATH = $PICO_SDK_PATH
$env:PICO_EXTRAS_PATH = $PICO_EXTRAS_PATH
$env:PATH = "$TOOLCHAIN_BIN;$NINJA_BIN;$CMAKE_BIN;$MINGW_BIN;$env:PATH"

# 3. Create and enter build directory
if (!(Test-Path build)) {
    New-Item -ItemType Directory -Path build
}
Set-Location build

# 4. Run CMake
Write-Host "Configuring project..." -ForegroundColor Cyan
cmake -G Ninja `
  -DCMAKE_C_COMPILER="$TOOLCHAIN_BIN\arm-none-eabi-gcc.exe" `
  -DCMAKE_CXX_COMPILER="$TOOLCHAIN_BIN\arm-none-eabi-g++.exe" `
  ..

if ($LASTEXITCODE -ne 0) {
    Write-Host "CMake configuration failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}

# 5. Build
Write-Host "Building project..." -ForegroundColor Cyan
ninja

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "Build successful! Output: build\ez_i2c_adapter_and_uart_bridge.uf2" -ForegroundColor Green
Set-Location ..
