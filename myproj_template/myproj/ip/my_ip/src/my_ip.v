module my_ip(
   input clk,
   output clk_alive
);

   reg [23:0] cnt;

   always @(posedge clk) begin
      cnt <= cnt + 1'b1;
   end

   assign clk_alive = cnt[23];

endmodule