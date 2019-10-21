
import "DPI-C" function void initialize_branch_predictor();



import "DPI-C" function void predict_branch(input longint ip,
                                            output bit    pred
                                            );

import "DPI-C" function void update_branch(input longint ip,
                                           input bit taken
                                           );

module BranchPredictorHarness (input clock,
                               input        reset,

                               input        req_valid,
                               input [63:0] req_pc,
                               output       req_taken,

                               input        update_valid,
                               input [63:0] update_pc,
                               input        update_taken
                               );

   initial begin
      initialize_branch_predictor();
   end

   bit _req_taken;

   assign req_taken = _req_taken;

   always @(posedge clock) begin
      if (!reset) begin
         if (req_valid) begin
            predict_branch(req_pc, _req_taken);
         end
         if (update_valid) begin
            update_branch(update_pc, update_taken);
         end
      end
   end

endmodule
