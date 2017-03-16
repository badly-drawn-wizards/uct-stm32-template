#include<stm32f0xx.h>
#include<stdint.h>
#include<math.h>

void delay() {
  for(uint32_t i=0; i<1000000; i++) {
  }
}

int main() {
 	RCC->AHBENR |= RCC_AHBENR_GPIOBEN;
  GPIOB->MODER = 0b0101010101010101;
  GPIOB->ODR = 0x0000;
  while(1) {
    GPIOB->ODR += 1;
    delay();
  }
}
