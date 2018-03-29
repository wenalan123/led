module  led(
        input                   clk                     ,
        input                   rst_n                   ,
        //led
        output  reg   [ 7: 0]   led 
);
//=====================================================================\
// ********** Define Parameter and Internal Signals *************
//=====================================================================/
parameter   TIME_1S     =       50_000_000                      ;
reg     [25: 0]                 cnt                             ;
wire                            add_cnt                         ;
wire                            end_cnt                         ;
wire                            time_1s                         ; 

//======================================================================
// ***************      Main    Code    ****************
//======================================================================
//led
always  @(posedge clk or negedge rst_n) begin
        if(rst_n == 1'b0)
            led     <=      'd0;
        else if(time_1s == 1'b1)
            led     <=      {led[ 6: 0],led[7]};
        else
            led     <=      led;
end

//cnt
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(add_cnt)begin
        if(end_cnt)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
end

assign add_cnt = 1'b1;       
assign end_cnt = add_cnt && cnt== TIME_1S-1; 

//time_1s
always  @(*) begin
        if(cnt >= TIME_1S-1)
            time_1s     =       1'b1;
        else
            time_1s     =       1'b0;
end








endmodule
