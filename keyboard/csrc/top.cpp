// #include "verilated.h"
// #include "verilated_vcd_c.h"
// #include "Vmux42.h"
#include <nvboard.h>
#include <Vtop.h>

static TOP_NAME top;
#define dut top

void nvboard_bind_all_pins(Vtop* top);

static void single_cycle() {
  dut.clk_i = 0; dut.eval();
  dut.clk_i = 1; dut.eval();
}

// static void reset(int n) {
//   dut.rst = 1;
//   while (n -- > 0) single_cycle();
//   dut.rst = 0;
// }

static void reset_n(int n) {
  dut.rst_n = 0;
  while (n -- > 0) single_cycle();
  dut.rst_n = 1;
}

int main() {
  nvboard_bind_all_pins(&dut);
  nvboard_init();

  reset_n(10);

  while(1) {
    nvboard_update();
    single_cycle();
  }

}

