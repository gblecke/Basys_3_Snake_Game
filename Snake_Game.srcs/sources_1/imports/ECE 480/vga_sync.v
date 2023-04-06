module vga_sync (
  input clock_25mhz, red, green, blue, reset,
  output reg red_out, green_out, blue_out, horiz_sync_out, vert_sync_out,
  output reg [9:0] pixel_row, pixel_col,
  output update
);

  parameter h_pixels_across = 640;
  parameter h_sync_low = 656;
  parameter h_sync_high = 752;
  parameter h_end_count = 800;

  parameter v_pixels_down = 480;
  parameter v_sync_low = 491;
  parameter v_sync_high = 493;
  parameter v_end_count = 524;

  reg [9:0] h_count, v_count;
  reg horiz_sync, vert_sync;
  reg video_on_v, video_on_h;
  
  wire video_on_int;

  assign video_on_int = video_on_h & video_on_v;
  
  assign update = ((v_count == v_end_count - 1) && h_count == h_end_count);
  
  // set up registers for these signals
  always @ (posedge reset or posedge clock_25mhz) begin
    if (reset) begin
      h_count <= 10'd0;
      horiz_sync <= 1'b1;
      v_count <= 10'd0;
      vert_sync <= 1'b1;
      video_on_h <= 1'b0;
      video_on_v <= 1'b0;
      horiz_sync_out <= 1'b0;
      vert_sync_out <= 1'b0;
      red_out <= 1'b0;
      blue_out <= 1'b0;
      green_out <= 1'b0;
    end else begin
      // generate horizontal and vertical timing counts for video signal
      if (h_count == h_end_count) begin
        h_count <= 10'd0;
      end else begin
        h_count <= h_count + 10'd1;
      end
  
      // generate horizontal sync signal using h_count
      if ((h_count < h_sync_high) && (h_count >= h_sync_low)) begin
        horiz_sync <= 1'b0;
      end else begin
        horiz_sync <= 1'b1;
      end
  
      // v_count counts rows of pixels
      if ((v_count >= v_end_count) && (h_count >= h_sync_low)) begin
        v_count <= 10'd0;
      end else if (h_count == h_sync_low) begin
        v_count <= v_count + 10'd1;
      end
  
      // generate vertical sync signal using v_count
      if ((v_count <= v_sync_high) && (v_count >= v_sync_low)) begin
        vert_sync <= 1'b0;
      end else begin
        vert_sync <= 1'b1;
      end
  
      // generate video on screen signals for pixel data
      if (h_count < h_pixels_across) begin
        video_on_h <= 1'b1;
      end else begin
        video_on_h <= 1'b0;
      end
      if (v_count <= v_pixels_down) begin
        video_on_v <= 1'b1;
      end else begin
        video_on_v <= 1'b0;
      end
  
      // put all signals through one cycle of DFFs to synchronize them
      horiz_sync_out <= horiz_sync;
      vert_sync_out <= vert_sync;
      red_out <= red & video_on_int;
      green_out <= green & video_on_int;
      blue_out <= blue & video_on_int;
      pixel_row <= h_count;
      pixel_col <= v_count;
    end
  end

endmodule
