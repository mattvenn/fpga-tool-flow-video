module top (
    input CLK,
    input BTN1,
    input BTN2,
    output LED1,
    output LED2,
    output LED3,
    output LED4,
    output LED5,
);
    assign LED1 = BTN1 & BTN2;

    /*
    assign {LED1,LED2,LED3,LED4,LED5} = register[22:18];
    reg [22:0] register;
    
    always @(posedge CLK) begin
        if(BTN1)
            register <= register + 1;
    end

    */

endmodule
