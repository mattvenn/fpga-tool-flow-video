module top (
    input BTN1,
    input BTN2,
    input BTN3,
    output LED1,
    output LED2,
    output LED3,
);

    assign LED1 = BTN1;
    assign LED2 = BTN1 & BTN2;
    assign LED3 = BTN3 | BTN2;

endmodule
