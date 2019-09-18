module top (
    input BTN1,
    input BTN2,
    output LED1,
);

    assign LED1 = BTN1 | BTN2;

endmodule
