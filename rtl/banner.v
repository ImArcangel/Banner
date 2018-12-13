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
    // ---------------------------------

    
    //para shiftear los estados del anodo y banner
    reg [4:0] state_b = 5'b0, nextstate_b = 5'b0;
    reg [1:0] state_a = 2'b0, nextstate_a = 2'b0;

    
    //Definicion de cada estado del banner
    parameter s0 = 5'b00000;
    parameter s1 = 5'b00001;
    parameter s2 = 5'b00010;
    parameter s3 = 5'b00011;
    parameter s4 = 5'b00100;
    parameter s5 = 5'b00101;
    parameter s6 = 5'b00110;
    parameter s7 = 5'b00111;
    parameter s8 = 5'b01000;
    parameter s9 = 5'b01001;
    parameter s10 = 5'b01010;
    parameter s11 = 5'b01011;
    parameter s12 = 5'b01100;
    parameter s13 = 5'b01101;
    parameter s14 = 5'b01110;
    parameter s15 = 5'b01111;
    parameter s16 = 5'b10000;
    parameter s17 = 5'b10001;
    parameter s18 = 5'b10010;
    parameter s19 = 5'b10011;

    //Definicion de cada estado del anodo
    parameter a0 = 2'b00;
    parameter a1 = 2'b01;
    parameter a2 = 2'b10;
    parameter a3 = 2'b11;

    //para la simulacion
    always @(*) begin
    	shift = tick_banner;
    end
    /*
    //cada flanco positivo del banner, cambia de estado el banner.
    always @(posedge tick_banner) begin
    	state_b <= nextstate_b;
    end*/

    //en cada estado del banner, nextstate_b apunta al siguiente estado del banner
    always @(*) begin

    	if(~rst) begin
    		
    		case(state_b) 
    			s0: nextstate_b = s1;
        		s1: nextstate_b = s2;
        		s2: nextstate_b = s3;
        		s3: nextstate_b = s4;
        		s4: nextstate_b = s5;
        		s5: nextstate_b = s6;
        		s6: nextstate_b = s7;
        		s7: nextstate_b = s8;
        		s8: nextstate_b = s9;
        		s9: nextstate_b = s10;
        		s10: nextstate_b = s11;
        		s11: nextstate_b = s12;
        		s12: nextstate_b = s13;
        		s13: nextstate_b = s14;
        		s14: nextstate_b = s15;
        		s15: nextstate_b = s16;
        		s16: nextstate_b = s17;
        		s17: nextstate_b = s18;
        		s18: nextstate_b = s19;
        		s19: nextstate_b = s0;
        		default: nextstate_b = s0;
        	endcase // state_b

        end else begin
        	nextstate_b = s0;
        end // end else

    end

    /*//cada flanco positivo del display, se cambia de estado el display
    always @(posedge tick_display) begin
    	state_a <= nextstate_a;
    end*/

    //en cada estado de anado, nexstate_a apunta al siguiente estado del anodo
    always @(*) begin
    	
    	if(~rst) begin

    		case(state_a) 
        		a0: nextstate_a = a1;
        		a1: nextstate_a = a2;
        		a2: nextstate_a = a3;
        		a3: nextstate_a = a0;
      		endcase
      	
      	end else begin
      		nextstate_a = a0;
      	end // end else
    
    end // always(*)

    always @(posedge clk) begin
      
		if(~rst) begin // Si no resetean

			if(tick_banner)
        state_b <= nextstate_b;
      if(tick_display)
        state_a <= nextstate_a;

      case (state_b) 

				s0: case (state_a) 
						default off_display <= 1;  
        			endcase
       
        		s1: case (state_a)
        				a3: begin off_display <= 0; number2show <= 4'h0; end
        				default off_display <= 1;
        			endcase

        		s2: case (state_a) 
          				a3: begin off_display <= 0; number2show <= 4'h1; end 
          				a2: begin off_display <= 0; number2show <= 4'h0; end 
          				default off_display <= 1;
        			endcase

        		s3: case (state_a) 
          				a3: begin off_display <= 0; number2show <= 4'h2; end 
          				a2: begin off_display <= 0; number2show <= 4'h1; end 
          				a1: begin off_display <= 0; number2show <= 4'h0; end 
          				a0: off_display <= 1;
        			endcase

        		s4: case (state_a) 
          				a3: begin off_display <= 0; number2show <= 4'h3; end 
          				a2: begin off_display <= 0; number2show <= 4'h2; end 
          				a1: begin off_display <= 0; number2show <= 4'h1; end 
          				a0: begin off_display <= 0; number2show <= 4'h0; end 
        			endcase

        		s5: case (state_a) 
          				a3: begin off_display <= 0; number2show <= 4'h4; end 
          				a2: begin off_display <= 0; number2show <= 4'h3; end 
          				a1: begin off_display <= 0; number2show <= 4'h2; end 
          				a0: begin off_display <= 0; number2show <= 4'h1; end 
          			endcase

        		s6: case (state_a) 
          				a3: begin off_display <= 0; number2show <= 4'h5; end 
          				a2: begin off_display <= 0; number2show <= 4'h4; end 
          				a1: begin off_display <= 0; number2show <= 4'h3; end 
          				a0: begin off_display <= 0; number2show <= 4'h2; end 
          			endcase

        		s7: case (state_a) 
          				a3: begin off_display <= 0; number2show <= 4'h6; end 
          				a2: begin off_display <= 0; number2show <= 4'h5; end 
          				a1: begin off_display <= 0; number2show <= 4'h4; end 
          				a0: begin off_display <= 0; number2show <= 4'h3; end
          			endcase

        		s8: case (state_a) 
          				a3: begin off_display <= 0; number2show <= 4'h7; end 
          				a2: begin off_display <= 0; number2show <= 4'h6; end 
          				a1: begin off_display <= 0; number2show <= 4'h5; end 
          				a0: begin off_display <= 0; number2show <= 4'h4; end
          			endcase

        		s9: case (state_a) 
          				a3: begin off_display <= 0; number2show <= 4'h8; end 
          				a2: begin off_display <= 0; number2show <= 4'h7; end 
          				a1: begin off_display <= 0; number2show <= 4'h6; end 
	          			a0: begin off_display <= 0; number2show <= 4'h5; end
    	      		endcase

        		s10: case (state_a)
          				a3: begin off_display <= 0; number2show <= 4'h9; end 
          				a2: begin off_display <= 0; number2show <= 4'h8; end 
          				a1: begin off_display <= 0; number2show <= 4'h7; end 
	          			a0: begin off_display <= 0; number2show <= 4'h6; end
    	      		endcase

	        	s11: case (state_a)
   		       			a3: begin off_display <= 0; number2show <= 4'hA; end 
        	  			a2: begin off_display <= 0; number2show <= 4'h9; end 
          				a1: begin off_display <= 0; number2show <= 4'h8; end 
          				a0: begin off_display <= 0; number2show <= 4'h7; end
          			endcase 

        		s12: case (state_a)
          				a3: begin off_display <= 0; number2show <= 4'hB; end 
          				a2: begin off_display <= 0; number2show <= 4'hA; end 
          				a1: begin off_display <= 0; number2show <= 4'h9; end 
          				a0: begin off_display <= 0; number2show <= 4'h8; end
          			endcase

        		s13: case (state_a)
          				a3: begin off_display <= 0; number2show <= 4'hC; end 
          				a2: begin off_display <= 0; number2show <= 4'hB; end 
          				a1: begin off_display <= 0; number2show <= 4'hA; end 
          				a0: begin off_display <= 0; number2show <= 4'h9; end
          			endcase 

        		s14: case (state_a)
          				a3: begin off_display <= 0; number2show <= 4'hD; end 
          				a2: begin off_display <= 0; number2show <= 4'hC; end 
          				a1: begin off_display <= 0; number2show <= 4'hB; end 
          				a0: begin off_display <= 0; number2show <= 4'hA; end
          			endcase 

        		s15: case (state_a)
          				a3: begin off_display <= 0; number2show <= 4'hE; end 
          				a2: begin off_display <= 0; number2show <= 4'hD; end 
          				a1: begin off_display <= 0; number2show <= 4'hC; end 
          				a0: begin off_display <= 0; number2show <= 4'hB; end 
          			endcase 

        		s16: case (state_a)
          				a3: begin off_display <= 0; number2show <= 4'hF; end 
          				a2: begin off_display <= 0; number2show <= 4'hE; end 
          				a1: begin off_display <= 0; number2show <= 4'hD; end 
          				a0: begin off_display <= 0; number2show <= 4'hC; end
          			endcase 

				s17: case (state_a)
          				a3: off_display <= 1;
          				a2: begin off_display <= 0; number2show <= 4'hF; end 
          				a1: begin off_display <= 0; number2show <= 4'hE; end 
          				a0: begin off_display <= 0; number2show <= 4'hD; end
          			endcase 

        		s18: case (state_a)
          				a1: begin off_display <= 0; number2show <= 4'hF; end 
          				a0: begin off_display <= 0; number2show <= 4'hE; end 
          				default off_display <= 1;
          			endcase 

        		s19: case (state_a)
          				a0: begin off_display <= 0; number2show <= 4'hF; end 
          				default off_display <= 1;
          			endcase

        		default case (state_a) 
          					default off_display <= 1; 
        				endcase
        	endcase //end case (state_b)
     	
     	end else begin
     		off_display <= 1;
        state_b <= s0;
        state_a <= a0;
      	end
	 
    end // always @(posedge clk)


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
