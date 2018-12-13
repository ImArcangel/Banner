// -----------------------------------------------------------------------------
// Autor: Angel Terrones <aterrones@usb.ve>
// Modulo: Driver 7-segmentos
// -----------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module driver7seg(
                  input wire       clk,
                  input wire       rst,
                  input wire       tick_display,
                  input wire [3:0] value,
                  input wire       off_display,
                  output reg [3:0] anodos,
                  output reg [7:0] segmentos
                  );
    //--------------------------------------------------------------------------
    reg [7:0] segment_ROM [0:15];

    initial begin
        segment_ROM[0]  = 8'h03;
        segment_ROM[1]  = 8'h9f;
        segment_ROM[2]  = 8'h25;
        segment_ROM[3]  = 8'h0d;
        segment_ROM[4]  = 8'h99;
        segment_ROM[5]  = 8'h49;
        segment_ROM[6]  = 8'h41;
        segment_ROM[7]  = 8'h1f;
        segment_ROM[8]  = 8'h01;
        segment_ROM[9]  = 8'h09;
        segment_ROM[10] = 8'h11;
        segment_ROM[11] = 8'hc1;
        segment_ROM[12] = 8'h63;
        segment_ROM[13] = 8'h85;
        segment_ROM[14] = 8'h61;
        segment_ROM[15] = 8'h71;
    end

    always @(posedge clk) begin
        if (rst)               anodos <= 4'b0001;
        else if (tick_display) anodos <= {anodos[2:0],anodos[3]};
    end

    always @(
        segment_ROM[0],
		segment_ROM[1], 
        segment_ROM[2], 
        segment_ROM[4],
        segment_ROM[5],
        segment_ROM[6],
        segment_ROM[7],
        segment_ROM[8],
        segment_ROM[9],
        segment_ROM[10],
        segment_ROM[11],
        segment_ROM[12],
        segment_ROM[13],
        segment_ROM[14],
        segment_ROM[15],
		off_display,
		value) begin
		  
        if (off_display) begin
            segmentos = 8'hff;
        end else begin
            segmentos = segment_ROM[value];
        end
    end
    //--------------------------------------------------------------------------
endmodule
// EOF
