((c-mode . ((flycheck-c/c++-gcc-executable . "arm-none-eabi-gcc")
            (flycheck-gcc-args . ("-mcpu=cortex-m0" "-mthumb" "-DSTM32F051"))
            (flycheck-gcc-include-path . ("." "../vendor/STM32F0xx_StdPeriph_Lib_V1.5.0/Libraries/CMSIS/Include" "../vendor/STM32F0xx_StdPeriph_Lib_V1.5.0/Libraries/CMSIS/Device/ST/STM32F0xx/Include"))
            (flycheck-checker . c/c++-gcc))))
