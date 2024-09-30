#include <avr/io.h>

int main() {
  DDRD = DDRD | (1 << PD4);
  DDRD = DDRD | (1 << PD5);
  DDRD = DDRD | (1 << PD6);
  DDRD &= ~(1 << PD3);
  while (1) {
    PORTD = PORTD | (1 << PD6);

    if (!(PIND & (1 << PD3))) {
      PORTD = PORTD & ~(1 << PD6);
      PORTD = PORTD | (1 << PD5);
      __builtin_avr_delay_cycles(47000000);
      PORTD = PORTD & ~(1 << PD5);
      PORTD = PORTD | (1 << PD4);
      __builtin_avr_delay_cycles(15500000);
      PORTD = PORTD & ~(1 << PD4);
    }
  }
}
