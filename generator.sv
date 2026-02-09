
class generator;
  transaction tr;
  mailbox #(transaction) mbx;
  event sconext;
  event drvnext;
  event done;
  int count=0;
  
  function new(mailbox #(transaction)mbx);
    this.mbx=mbx;
    tr=new();
  endfunction
  
  task run();
    repeat(count) begin
      assert(tr.randomize) else $error("randomization error");
      mbx.put(tr.copy);
      $display("[GEN]: Oper : %0s Din : %0d",tr.oper.name(), tr.dintx);
      @(drvnext);
      @(sconext);
    end
    
    -> done;
  endtask
endclass
