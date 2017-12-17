module nco( i_clk, i_ld, i_dphase, i_ce, o_val);
    parameter   LGTBL = 8,
                W = 32,
                OW = 7; 
    localparam  P = LGTBL;

    input   wire            i_clk;
    input   wire            i_ld;
    input   wire [W-1:0]    i_dphase;
    input   wire            i_ce;
    output  wire [OW-1:0]   o_val;

    reg     [W-1:0] r_step;

    initial r_step = 0;
    always @(posedge i_clk)
    if(i_ld)
        r_step <= i_dphase; // = 2^W * f/fs

    reg     [W-1:0] r_phase;

    initial r_phase = 0;
    always @(posedge i_clk)
    if(i_ce) begin
        r_phase <= r_phase + r_step;
    end

    reg [(OW-1):0]      sin_tbl  [0:(1<<P)-1];

    // table from http://www.daycounter.com/Calculators/Sine-Generator-Calculator2.phtml
    initial $readmemh("table.hex", sin_tbl);

    assign o_val = sin_tbl[r_phase[(W-1):(W-P)]];

endmodule
