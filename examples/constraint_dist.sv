// Random value distribution by Weight

module test;

   class pkt;

      rand int data;
   
      constraint data_range {
         data dist {'h0000:/1, 'hffff:/95, ['h0001:'hfffe]:/ 4};
      }
   endclass


   pkt pkt_;

   // Collect randomized hits on PKT distribution data values
   int set_1, set_2, set_3;
   int loopCount = 100;

   initial
   begin
      pkt_ = new();

      for(int idx = 0; idx < loopCount; idx++)
      begin
         if(!pkt_.randomize())
            $fatal;
         $display(" [RANDOMIZE]:  Index (%0d) Data Value = %h", idx, pkt_.data);

         categorize(pkt_.data);
      end

      $display(" [RESULT]: Total Hits: %0d, SET1 = %0d, SET2 = %0d, SET3 = %0d",
         loopCount, set_1, set_2, set_3);
   end


   // Count number of Hits for a given range of values in CASE
   function void categorize(int data);
      case(data)
         'h0    : set_1++;
         'hFFFF : set_2++;
         default: set_3++; // For range of 'h1 to 'hFFFE
      endcase
   endfunction

endmodule
