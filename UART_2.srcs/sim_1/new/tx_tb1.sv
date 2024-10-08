module four_byte_tx_tb();

    // Inputs
    reg clk;
    reg [7:0] data;
    reg btn_load;
    reg btn_trans;
    reg act ;
    // Outputs
    wire bit_to_send;
    wire [7:0] data_prev;
    
    // Instantiate the unit under test (UUT)
    four_byte_tx uut (
        .clk(clk),
        .act(act) ,
        .data(data),
        .btn_load(btn_load),
        .btn_trans(btn_trans),
        .bit_to_send(bit_to_send),
        .data_prev(data_prev)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        clk = 0;
        btn_load = 0;
        btn_trans = 0;
        data = 8'hFF; // Example data
        
        #10; // Allow some time for initialization
        
        // Load data
        btn_load = 1;
        #10;
        btn_load = 0;
        #10;
        act = 0 ;
        btn_load = 0;
        btn_trans = 0;
        data = 8'hAA; // Example data
        
        #10; // Allow some time for initialization
        
        // Load data
        btn_load = 1;
        #10;
        btn_load = 0;
        #10;
        btn_load = 0;
        btn_trans = 0;
        data = 8'hEE; // Example data
        
        #10; // Allow some time for initialization
        
        // Load data
        btn_load = 1;
        #10;
        btn_load = 0;
        #10;
        btn_load = 0;
        btn_trans = 0;
        data = 8'hCC; // Example data
        
        #10; // Allow some time for initialization
        
        // Load data
        btn_load = 1;
        #10;
        btn_load = 0;
        #10;
        // Start transmission
        btn_trans = 1;
        #10; // Transmit for a while
        act = 1 ;
        #10
        btn_trans = 1 ;
        // Stop simulation
        $finish;
    end
    
    // Add waveform dump tasks if needed
    
endmodule