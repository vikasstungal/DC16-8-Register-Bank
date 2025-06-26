module tb_dual_clock_reg_bank;
    reg CLKA;
    reg CLKB;
    reg [3:0] addrA;
    reg [3:0] addrB;
    reg [7:0] data_inA;
    reg weA;
    wire [7:0] data_outA;
    wire [7:0] data_outB;
    integer i=0;
     dual_clock_reg_bank dut( .CLKA(CLKA),.CLKB(CLKB),.addrA(addrA),.addrB(addrB),.data_inA(data_inA),.weA(weA),.data_outA(data_outA),.data_outB(data_outB));
  initial begin
    CLKA = 0;
    forever#10CLKA= ~CLKA;
    end
    initial begin
    CLKB = 0;
    forever#15 CLKB=~CLKB;
    end
    initial
    begin
  addrA= 0;
addrB = 0;
 data_inA = 0;
        weA = 0;
    #20;
  weA = 1;
        for(i = 0; i < 16; i = i + 1)
             begin

            addrA = i;
            data_inA = $random;
            #20;
  end
        weA = 0;
 for(i = 0; i < 16; i = i + 1)
      begin

            addrA = i;
            addrB = i;
            #30;
$display("Reg[%0d]: PortA=%h, PortB=%h", i, data_outA, data_outB);
        end
 addrA = 5;
        addrB = 5;
        data_inA = 8'hAA;
        weA = 1;
        #20;
        weA = 0;
        #30;
        $display("Concurrent test: PortA=%h, PortB=%h", data_outA, data_outB);

        $finish;
    end
endmodule
