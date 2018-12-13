// -----------------------------------------------------------------------------
// Autor: Angel Terrones <aterrones@usb.ve>
// Modulo: Driver 7-segmentos
// -----------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module banner #(
                parameter CLK_XTAL    = 50000000,
                parameter CLK_DISPLAY = 240,
                parameter CLK_BANNER  = 1
                )(
                  input wire        clk,
                  input wire        rst,
                  output wire [3:0] anodos,
                  output wire [7:0] segmentos,
                  output reg        shift
                  );
    //--------------------------------------------------------------------------
    // WARNING: READ ONLY
    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire                tick_banner;            // From clkdiv of clk_div.v
    wire                tick_display;           // From clkdiv of clk_div.v
    // End of automatics
    reg [3:0] number2show = 4'h0;
    reg       off_display;
    reg [3:0] cnt_b = 4'h0;
    reg [3:0] cnt_a = 4'h0;
    reg [3:0] cnt_c = 4'h0;
    // ---------------------------------

    always @(*) begin
    	shift = tick_banner;
    	cnt_c = cnt_a + cnt_b;
    	number2show = cnt_c - 4;
    end

    always @(posedge clk) begin
     
      case (cnt_c)  	
      	4'h0: off_display<=1;
      	4'h1: off_display<=1;
      	4'h2: off_display<=1;
      	4'h3: off_display<=1;
      	default off_display <=0;
      endcase // cnt_c

      if(~rst) begin
        
        if(tick_banner) begin 
          
          if(cnt_b == 15) begin
            cnt_b <= 0;
          end else begin
            cnt_b <= cnt_b+1;
          end // end else 

        end // end if(tick_banner)

        
        if(tick_display) begin
			
			if(cnt_a == 3) begin
            	cnt_a <= 0;
          	end else begin
            	cnt_a <= cnt_a+1;
          	end // end else


		end // end if(tick_display)


      end else begin // end if(~rst)
        off_display <= 1;
        cnt_a <= 0;
        cnt_b <= 0;
      end // end else if(~rst)
    end //  end always

    // ---------------------------------
    // WARNING: READ ONLY
    // instanciacion
    clk_div #(/*AUTOINSTPARAM*/
              // Parameters
              .CLK_XTAL                 (CLK_XTAL),
              .CLK_DISPLAY              (CLK_DISPLAY),
              .CLK_BANNER               (CLK_BANNER)
              ) clkdiv (/*AUTOINST*/
                        // Outputs
                        .tick_display     (tick_display),
                        .tick_banner      (tick_banner),
                        // Inputs
                        .clk              (clk),
                        .rst              (rst));

    driver7seg driver(.value            (number2show[3:0]),
                      /*AUTOINST*/
                      // Outputs
                      .anodos           (anodos[3:0]),
                      .segmentos        (segmentos[7:0]),
                      // Inputs
                      .clk              (clk),
                      .rst              (rst),
                      .tick_display     (tick_display),
                      .off_display      (off_display));
    //--------------------------------------------------------------------------
endmodule
// EOF
