
module tb;
    
  uart_if vif();
  
  uart_top #(1000000, 9600) dut (vif.clk,vif.rst,vif.rx,vif.newd,vif.dintx,vif.tx,vif.donetx, vif.donerx,vif.doutrx);
  
  
  
    initial begin
      vif.clk <= 0;
    end
    
    always #10 vif.clk <= ~vif.clk;
    
    environment env;
    
    
    
    initial begin
      env = new(vif);
      env.gen.count = 5;
      env.run();
    end
      
    
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
   
  assign vif.uclktx = dut.utx.uclk;
  assign vif.uclkrx = dut.rtx.uclk;
    
  endmodule
  