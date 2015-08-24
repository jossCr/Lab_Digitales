`timescale 1ns / 1ps


module Codigo1(clk, ps2_data, ps2_clk, ps2_data_out, pulso_done
    );
	 
	 input clk;
	 input ps2_clk, ps2_data;
	 output [7:0]ps2_data_out;
	 output reg pulso_done;
	  
	 //variables del programa   
	 reg [7:0] filtro_antirebote;
	 reg ps2_clk_negedge;
	 reg [2:0] estado=0;
	 reg [7:0] contador=0;
	 reg [7:0] data_p;
	 reg data_in; 
	 
	 localparam [2:0]
	 idle = 3'b000,
	 uno = 3'b001,
	 dos = 3'b010,
	 tres = 3'b011,
	 cuatro = 3'b100;
	 
	 always @ (posedge clk)
	 begin 
	 filtro_antirebote [7:0]<= {ps2_clk, filtro_antirebote[7:1]};
	 end
	 
	 always @ (posedge clk)
	
	begin 
	if (filtro_antirebote == 8'b00001111)
		ps2_clk_negedge <= 1'b1;
	else
		ps2_clk_negedge <= 1'b0;
	end 
	
	always @ (posedge clk)
	begin
	if (ps2_clk_negedge)
	data_in <= ps2_data;
	else 
	data_in <= data_in;
	end
	
	 always @ (posedge clk)
	 begin 
	 case (estado)
	 idle: begin
		
		data_p <= data_p;
		contador <= 4'd0;
		pulso_done <=1'b0;
		
			if (ps2_clk_negedge)
				estado<= uno;
			
			else
				estado<= uno;
			
			end
		uno: begin
			data_p<=data_p;
			contador <= contador;
			pulso_done <= 1'b0;
			
			if (ps2_clk_negedge)
			begin 	
				if (contador == 4'd8)
				
					estado<=tres;
				else 	
					estado <= dos;
				end
				
					else 
						estado<= uno;
				end
				
			dos: begin
				data_p [7:0] <= {data_in, data_p[7:1]};
				contador <=  contador +1;
				pulso_done <= 1'b0;
				estado <= uno;
				end
				
			tres: begin
				estado <= cuatro;
				pulso_done <=1'b1;
				data_p <=data_p;
				contador <= 4'd0;
				end
			cuatro: begin
				data_p <= data_p;
				contador <= 4'd0;
				pulso_done <= 1'b0;
				
				if (ps2_clk_negedge)
					estado <= idle;
				end
			endcase
			end
			
			assign  ps2_data_out = data_p;
			
endmodule

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:17 08/11/2015 
// Design Name: 
// Module Name:    MaquinaE 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//   
// Revision: 
// Revision 0.01 - File Created   
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//revisar estado profe 
module MaquinaE(
		input wire clk, reset,
		input wire [3:0] sensores,
		output reg [6:0] salida,
		output reg [3:0] display,
		output reg [7:0] sevenseg,
		//output reg signed [3:0] state_reg /////Se ponen los estados como una salida para de esta forma supervisar el estado en el que se encuentra la maquina
		output reg signed [3:0] estado /////the internal signal connected to the port is a signed reg data type
    );
	  ////Parametros de 0 a 15
	 parameter e0=4'b0000,e1=4'b0001,e2=4'b0010,e3=4'b0011,e4=4'b0100,e5=4'b0101,e6=4'b0110,e7=4'b0111,e8=4'b1000,e9=4'b1001,e10=4'b1010,e11=4'b1011,e12=4'b1100,e13=4'b1101,e14=4'b1110,e15=4'b1111;
	 parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b0011,s4=4'b1000,s5=4'b0101,s6=4'b0110,s7=4'b0111,s8=4'b1000,s9=4'b1001,s10=4'b1010,s11=4'b1011,s12=4'b1100,s13=4'b1101,s14=4'b1110,s15=4'b1111;
	 
	 reg [3:0] estado_p, estado_s; 
	 
	 always @(posedge clk, posedge reset)
		 
		 if (reset)
			begin
			estado_p<=s0;
			//display=4'b1111;
			//sevenseg=8'b11111111;

			end
		 else 
			estado_p<=estado_s;
			
			
	always@* //logica de siguiente de estado y logica de salida
	begin  
		//salida=7'b0000000;
		
		estado_s = estado_p;
			case (estado_p)
			
					s0: 
						begin 
							///salida=7'b0000001;
							
							if (sensores == 4'b0000)
								begin
								salida=7'b0000001;
								
								display=4'b1111;
								sevenseg=8'b11111111;
								estado_s=s0;
								end
							else
								if(sensores==e0)
								estado_s=s0;
								//salidas<=7'b0000001;
							else if(sensores==e1)
								//salidas<=7'b0000001;
								estado_s=s1;
							else if(sensores==e2)
								//salidas<=7'b0000001;
								estado_s=s2;
							else if(sensores==e3)
								//salidas<=7'b0000001;
								estado_s=s3;
							else if(sensores==e4)
								//salidas<=7'b0000001;
								estado_s=s4;
							else if(sensores==e5)
								//salidas<=7'b0000001;
								estado_s=s5;
							else if(sensores==e6) 
								//salidas<=7'b0000001;
								estado_s=s6;
							else if(sensores==e7)
								//salidas<=7'b0000001;
								estado_s=s7;
							else if(sensores==e8)
								//salidas<=7'b0000001;
								estado_s=s8;
							else if(sensores==e9)
								//salidas<=7'b0000001;
								estado_s=s9;
							else if(sensores==e10)
								//salidas<=7'b0000001;
								estado_s=s10;
							else if(sensores==e11)
								//salidas<=7'b0000001;
								estado_s=s11;
							else if(sensores==e12)
								//salidas<=7'b0000001;
								estado_s=s12;
							else if(sensores==e13)
								//salidas<=7'b0000001;
								estado_s=s13;
							else if(sensores==e14)
								//salidas<=7'b0000001;
								estado_s=s14;
							else if(sensores==e15)
								//salidas<=7'b0000001;
								estado_s=s15;
										
						 end
					
			
					s1:	 							
						begin 
							salida=7'b1000000;
							if (sensores == 4'b0001)
								begin
								estado_s=s1;
								display=4'b1110;//hola
								sevenseg=8'b10011111;
								end
								
							else
								estado_s=s0;
										
						 end	
					s2:
						begin 
							salida=7'b1011100;
							if (sensores == 4'b0010)
								begin
								estado_s=s2;
								display=4'b1101;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s3:
						 begin 
							salida=7'b1011110; 
							if (sensores == 4'b0011)
								begin
								estado_s=s3;
								display=4'b1100;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s4:
						 begin 
							salida=7'b1100000;
							if (sensores == 4'b0100)
								begin
								estado_s=s4;
								display=4'b1011;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s5:
						 begin 
							salida=7'b1100010;
							if (sensores == 4'b0101)
								begin
								estado_s=s5;
								display=4'b1010;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s6:
						begin 
							salida=7'b1111110;
							if (sensores == 4'b0110)
								begin
								estado_s=s6;
								display=4'b1001;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s7:
						begin 
							salida=7'b1111110;
							if (sensores == 4'b0111)
								begin
								estado_s=s7;
								display=4'b1000;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end	
					s8:
						begin 
							salida=7'b1110000;
							if (sensores == 4'b1000)
								begin
								estado_s=s8;
								display=4'b0111;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end 
					s9:
						begin 
							salida=7'b1010010;
							if (sensores == 4'b1001)
								begin
								estado_s=s9;
								display=4'b0110;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s10: 
						begin 
							salida=7'b1011110;
							if (sensores == 4'b1010)
								begin
								estado_s=s10;
								display=4'b0101;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end	
					s11:
						 begin 
							salida=7'b1011110;
							if (sensores == 4'b1011)
								begin
								estado_s=s11;
								display=4'b0100;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end		
					s12:
						 begin 
							salida=7'b1110010;
							if (sensores == 4'b1100)
								begin
								estado_s=s12;
								display=4'b0011;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s13:
						 begin 
							salida=7'b1110010;
							if (sensores == 4'b1101)
								begin
								estado_s=s13;
								display=4'b0010;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s14:
						 begin 
							salida=7'b0000001;
							if (sensores == 4'b1110)
								begin
								estado_s=s14;
								display=4'b0001;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					s15:
						 begin 
							salida=7'b1111110;
							if (sensores == 4'b1111)
								begin
								estado_s=s15;
								display=4'b0000;
								sevenseg=8'b10011111;
								end
							else
								estado_s=s0;
										
						 end
					
						 
							
					default estado_s=s0;
					endcase
		
	end
	 


endmodule


module comparador(
		input wire clk, 
		output reg [3:0] sensores,
		input wire [7:0]ps2_data_out, ////// Salidas del modulo que van a ir conectadas al otro
		input wire pulso_done //////// 
		);
		
endmodule
