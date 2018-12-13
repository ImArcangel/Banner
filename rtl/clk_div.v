// -----------------------------------------------------------------------------
// Autor: Angel Terrones <aterrones@usb.ve>
// Modulo: clock divider
// -----------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module clk_div #(
                 parameter CLK_XTAL    = 50000000,
                 parameter CLK_DISPLAY = 240,
                 parameter CLK_BANNER  = 1
                 )(
                   input wire clk,
                   input wire rst,
                   output reg tick_display,
                   output reg tick_banner
                   );
    //--------------------------------------------------------------------------
    //WARNING: (CLK_DISPLAY/CLK_BANNER) % 4 == 0

    //dos contadores para crear un clock de 1 hz (tick_banner) y otro de 60 hz (tick_display)
    reg [25:0] cnt1, cnt2;

    always @(posedge clk) begin
      
      //cuando el contador llega a 50 Mhz/1 se resetea y al mismo tiempo hace que tickbanner valga 1, inmediatamente despues tickbaner vale cero
      //hasta que ocurra la condicion de nuevo. Esto transforma a tickbanner a 1 hz. (recuerda que el clock es de 50Mhz por segundo)
      if(~rst)begin      

        if(cnt1 == CLK_XTAL/CLK_BANNER) begin
          cnt1 <= 0;
        end else begin
          cnt1 <= cnt1+1;
        end
      
        tick_banner <= (cnt1 == CLK_XTAL/CLK_BANNER)? 1:0;

        //cuando el contador llega a 50 Mhz/60 se resetea y al mismo tiempo hace que tickdisplay valga 1, inmediatamente despues tickdisplay
        //vale cero hasta que ocurra la condicion de nuevo. Esto transforma a tickdisplay a 60 hz, 60 veces por segundo.
        //(recuerda que el clock es de 50Mhz por segundo).    
        if(cnt2 == CLK_XTAL/CLK_DISPLAY) begin
          cnt2 <= 0;
        end else begin
          cnt2 <= cnt2+1;
        end
      
        tick_display <= (cnt2 == CLK_XTAL/CLK_DISPLAY)? 1:0;

        //Si presionan reset, reinicia los contadores y baja las señales de tickbanner y tickdisplay    
      end else begin
        cnt1 <= 0;
        cnt2<=0;
        tick_banner <= 0;
        tick_display <= 0;
      end // end else
      
    end // always @(posedge clk)


    //--------------------------------------------------------------------------
endmodule // clk_div
// EOF
