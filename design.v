module dual_clock_reg_bank (
    input wire CLKA,
    input wire CLKB,
    input wire [3:0] addrA,
    input wire [3:0] addrB,
    input wire [7:0] data_inA,
    input wire weA,
    output reg [7:0] data_outA,
    output reg [7:0] data_outB
);

    // Register bank declaration
    reg [7:0] reg_bank [0:15];
    
    // Port A (Read/Write) - CLKA domain
    always @(posedge CLKA) begin
        if (weA) begin
            reg_bank[addrA] <= data_inA;
        end
        data_outA <= reg_bank[addrA];
    end
    
    // Port B (Read-only) - CLKB domain
    always @(posedge CLKB) begin
        data_outB <= reg_bank[addrB];
    end

endmodule
