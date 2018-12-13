/**
 * Autor: Ángel Terrones <aterrones@usb.ve>
 */
module tb_banner;

    reg clk;
    reg rst;
    wire [3:0] anodos;
    wire [7:0] segmentos;
    wire shift;

    initial begin
        $dumpfile("dut.vcd");
        $dumpvars(0, dut);
        $from_myhdl(
                    clk,
                    rst
                    );
        $to_myhdl(
                  anodos,
                  segmentos,
                  shift
                  );
    end

    banner #(600, 60, 5
             ) dut (
                    clk,
                    rst,
                    anodos,
                    segmentos,
                    shift
                    );
endmodule
// EOF
