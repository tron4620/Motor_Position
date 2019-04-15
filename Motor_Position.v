
module Motor_Position (

	input CLOCK_50_B5B,
	input CPU_RESET_n,

	output LEDG
	
);

// Clocks
wire clk_100;
wire pll_locked;

wire pllReset;

reg pllLock_d1 = 0;
reg pllLock_d2 = 0;
wire resetN;

//PWM
reg highCount;
reg lowCount;

reg state [1:0];

wire LEDGInt;

localparam ST_IDLE = 4'h0;
localparam ST_HIGH = 4'h1;
localparam ST_LOW = 4'h2; 

assign pllReset = ~CPU_RESET_n;
assign resetN = pllLock_d2;

assign LEDG = LEDGInt;

always@(posedge clk_100) 
begin

	if (!resetN) begin
		state <= ST_IDLE;
		highCount <= 0;
		lowCount <= 0;
		LEDGInt <= 0;
	end
	
	else begin 
	
		case (state)
			ST_IDLE: begin
				state <= ST_HIGH;
			end
			
			ST_HIGH: begin
				highCount <= highCount +1;
				if (highCount >= 100000) begin
					LEDGInt <= 0;
					highCount <= 0;
					state <= ST_LOW;
				end
			end
			
			ST_LOW: begin
				lowCount <= lowCount +1;
				if (lowCount >= 100000) begin
					LEDGInt <= 1;
					lowCount <= 0;
					state <= ST_HIGH;
				end
			end
			
			default: begin
				state <= ST_IDLE;
			end
		endcase
	end
	
end

always@(posedge clk_100)
begin
	pllLock_d1 <= pll_locked;
	pllLock_d2 <= pllLock_d1;	
end


clock_divider	mainPll(

	.refclk(CLOCK_50_B5B),
	.rst(pllReset),
	
	.outclk_0(clk_100),
	
	.locked(pll_locked)
);

endmodule
