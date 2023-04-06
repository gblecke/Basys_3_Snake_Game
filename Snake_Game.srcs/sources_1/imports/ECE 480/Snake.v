module Snake (
  input gameOn,
  input [9:0] pixel_row, pixel_column,
  input [1:0] dir,
  input update,
  input sw_pause,
  output reg red, green, blue
);
  
  //defined values to make directions easier to follow
  `define UP 2'b00
  `define RIGHT 2'b01
  `define DOWN 2'b10
  `define LEFT 2'b11
  
  //base variables
  wire [9:0] section_size;  //variable to assign size of snake
  reg [4:0] length = 5'd4;  //maximum length of 31 links
  
  //background and apple variable instantion w/ base case
  wire body_collision;
  reg background;
  reg apple;
  reg [9:0] applex = 10'd400, appley = 10'd300;
  reg apple_eaten;
  
  //snake links
  //number of links if maximum length of the snake
  reg head;
  reg [9:0] headx, heady;
  reg section1;
  reg [9:0] section1x, section1y;
  reg section2;
  reg [9:0] section2x, section2y;
  reg section3;
  reg [9:0] section3x, section3y;
  reg section4;
  reg [9:0] section4x, section4y;
  reg section5;
  reg [9:0] section5x, section5y;
  reg section6;
  reg [9:0] section6x, section6y;
  reg section7;
  reg [9:0] section7x, section7y;
  reg section8;
  reg [9:0] section8x, section8y;
  reg section9;
  reg [9:0] section9x, section9y;
  reg section10;
  reg [9:0] section10x, section10y;
  reg section11;
  reg [9:0] section11x, section11y;
  reg section12;
  reg [9:0] section12x, section12y;
  reg section13;
  reg [9:0] section13x, section13y;
  reg section14;
  reg [9:0] section14x, section14y;
  reg section15;
  reg [9:0] section15x, section15y;
  reg section16;
  reg [9:0] section16x, section16y;
  reg section17;
  reg [9:0] section17x, section17y;
  reg section18;
  reg [9:0] section18x, section18y;
  reg section19;
  reg [9:0] section19x, section19y;
  reg section20;
  reg [9:0] section20x, section20y;
  reg section21;
  reg [9:0] section21x, section21y;
  reg section22;
  reg [9:0] section22x, section22y;
  reg section23;
  reg [9:0] section23x, section23y;
  reg section24;
  reg [9:0] section24x, section24y;
  reg section25;
  reg [9:0] section25x, section25y;
  reg section26;
  reg [9:0] section26x, section26y;
  reg section27;
  reg [9:0] section27x, section27y;
  reg section28;
  reg [9:0] section28x, section28y;
  reg section29;
  reg [9:0] section29x, section29y;
  reg section30;
  reg [9:0] section30x, section30y;
  //desired size of snake squares
  assign section_size = 10'd10;
  
  //pause register
  reg pause;
  always @(*) begin
    if(sw_pause) begin
      pause = 1'b1;
    end else if((headx > 619) || (headx < 21) || (heady > 459) || (heady < 21)) begin
      pause = 1'b1;
    end else if(body_collision) begin  //check if the head collided with any collidable section
      pause = 1'b1;
    end else if(gameOn || ~sw_pause) begin
      pause = 1'b0;
    end
  end

  ///movement register
  always @(posedge update) begin
    apple_eaten <= 0;
    if(~gameOn) begin
      length = 5'd4;
      applex = 10'd400; appley = 10'd300;
      headx = 10'd200; heady = 10'd150;
      section1x = 10'd190; section1y = 10'd150;
      section2x = 10'd180; section2y = 10'd150;
      section3x = 10'd170; section3y = 10'd150;
      section4x = 10'd0; section4y = 10'd0;
      section5x = 10'd0; section5y = 10'd0;
      section6x = 10'd0; section6y = 10'd0;
      section7x = 10'd0; section7y = 10'd0;
      section8x = 10'd0; section8y = 10'd0;
      section9x = 10'd0; section9y = 10'd0;
      section10x = 10'd0; section10y = 10'd0;
      section11x = 10'd0; section11y = 10'd0;
      section12x = 10'd0; section12y = 10'd0;
      section13x = 10'd0; section13y = 10'd0;
      section14x = 10'd0; section14y = 10'd0;
      section15x = 10'd0; section15y = 10'd0;
      section16x = 10'd0; section16y = 10'd0;
      section17x = 10'd0; section17y = 10'd0;
      section18x = 10'd0; section18y = 10'd0;
      section19x = 10'd0; section19y = 10'd0;
      section20x = 10'd0; section20y = 10'd0;
      section21x = 10'd0; section21y = 10'd0;
      section22x = 10'd0; section22y = 10'd0;
      section23x = 10'd0; section23y = 10'd0;
      section24x = 10'd0; section24y = 10'd0;
      section25x = 10'd0; section25y = 10'd0;
      section26x = 10'd0; section26y = 10'd0;
      section27x = 10'd0; section27y = 10'd0;
      section28x = 10'd0; section28y = 10'd0;
      section29x = 10'd0; section29y = 10'd0;
      section30x = 10'd0; section30y = 10'd0;
    end else if(~pause) begin
      if((((headx - applex < 10) && (headx - applex >= 0)) || ((applex - headx >= 0) && (applex - headx < 10))) && (((heady - appley < 10) && (heady - appley >= 0)) || ((appley - heady < 10)) && (appley - heady >= 0))) begin
        if(length != 5'b11111) begin
          length <= length + 4'd1;
        end
        apple_eaten <= 1;
      end
    
      if(apple_eaten) begin
        applex <= 10'd80 + (headx * 2 + section1x * 2 + section2x * 2) % 450;
        appley <= 10'd80 + (heady * 2 + section1y * 2) % 320;
        apple_eaten <= 0;
      end
    
      section1x <= headx;
      section1y <= heady;
    
      if(length > 5'd2) begin
        section2x <= section1x;
        section2y <= section1y;
      end 
      if(length > 5'd3) begin
        section3x <= section2x;
        section3y <= section2y;
      end
      if(length > 5'd4) begin
        section4x <= section3x;
        section4y <= section3y;
      end
      if(length > 5'd5) begin
        section5x <= section4x;
        section5y <= section4y;
      end
      if(length > 5'd6) begin
        section6x <= section5x;
        section6y <= section5y;
      end 
      if(length > 5'd7) begin
        section7x <= section6x;
        section7y <= section6y;
      end 
      if(length > 5'd8) begin
        section8x <= section7x;
        section8y <= section7y;
      end 
      if(length > 5'd9) begin
        section9x <= section8x;
        section9y <= section8y;
      end 
      if(length > 5'd10) begin
        section10x <= section9x;
        section10y <= section9y;
      end 
      if(length > 5'd11) begin
        section11x <= section10x;
        section11y <= section10y;
      end 
      if(length > 5'd12) begin
        section12x <= section11x;
        section12y <= section11y;
      end 
      if(length > 5'd13) begin
        section13x <= section12x;
        section13y <= section12y;
      end 
      if(length > 5'd14) begin
        section14x <= section13x;
        section14y <= section13y;
      end 
      if(length > 5'd15) begin
        section15x <= section14x;
        section15y <= section14y;
      end 
      if(length > 5'd16) begin
        section16x <= section15x;
        section16y <= section15y;
      end 
      if(length > 5'd17) begin
        section17x <= section16x;
        section17y <= section16y;
      end 
      if(length > 5'd18) begin
        section18x <= section17x;
        section18y <= section17y;
      end 
      if(length > 5'd19) begin
        section19x <= section18x;
        section19y <= section18y;
      end 
      if(length > 5'd20) begin
        section20x <= section19x;
        section20y <= section19y;
      end 
      if(length > 5'd21) begin
        section21x <= section20x;
        section21y <= section20y;
      end 
      if(length > 5'd22) begin
        section22x <= section21x;
        section22y <= section21y;
      end 
      if(length > 5'd23) begin
        section23x <= section22x;
        section23y <= section22y;
      end 
      if(length > 5'd24) begin
        section24x <= section23x;
        section24y <= section23y;
      end 
      if(length > 5'd25) begin
        section25x <= section24x;
        section25y <= section24y;
      end 
      if(length > 5'd26) begin
        section26x <= section25x;
        section26y <= section25y;
      end 
      if(length > 5'd27) begin
        section27x <= section26x;
        section27y <= section26y;
      end 
      if(length > 5'd28) begin
        section28x <= section27x;
        section28y <= section27y;
      end 
      if(length > 5'd29) begin
        section29x <= section28x;
        section29y <= section28y;
      end 
      if(length > 5'd30) begin
        section30x <= section29x;
        section30y <= section29y;
      end   
    
      if(dir == `UP) begin
        heady <= heady - section_size;
      end else if(dir == `RIGHT) begin
        headx <= headx + section_size;
      end else if(dir == `DOWN) begin
        heady <= heady + section_size;
      end else if(dir == `LEFT) begin
        headx <= headx - section_size;
      end
    end
  end
  
  //object area instantiation
  always @(*) begin
    background = (pixel_row > 10'd20) && (pixel_row < 10'd620) && (pixel_column > 10'd20) && (pixel_column < 10'd460);
    
    apple = (pixel_row > applex) && (pixel_row < applex + 10'd10) && (pixel_column > appley) && (pixel_column < appley + 10'd10);
    
    head = (pixel_row > headx) && (pixel_row < headx + section_size) && (pixel_column > heady) && (pixel_column < heady + section_size);
    section1 = (pixel_row > section1x) && (pixel_row < section1x + section_size) && (pixel_column > section1y) && (pixel_column < section1y + section_size);
    section2 = (pixel_row > section2x) && (pixel_row < section2x + section_size) && (pixel_column > section2y) && (pixel_column < section2y + section_size);
    section3 = (pixel_row > section3x) && (pixel_row < section3x + section_size) && (pixel_column > section3y) && (pixel_column < section3y + section_size);
    section4 = (pixel_row > section4x) && (pixel_row < section4x + section_size) && (pixel_column > section4y) && (pixel_column < section4y + section_size);
    section5 = (pixel_row > section5x) && (pixel_row < section5x + section_size) && (pixel_column > section5y) && (pixel_column < section5y + section_size);
    section6 = (pixel_row > section6x) && (pixel_row < section6x + section_size) && (pixel_column > section6y) && (pixel_column < section6y + section_size);
    section7 = (pixel_row > section7x) && (pixel_row < section7x + section_size) && (pixel_column > section7y) && (pixel_column < section7y + section_size);
    section8 = (pixel_row > section8x) && (pixel_row < section8x + section_size) && (pixel_column > section8y) && (pixel_column < section8y + section_size);
    section9 = (pixel_row > section9x) && (pixel_row < section9x + section_size) && (pixel_column > section9y) && (pixel_column < section9y + section_size);
    section10 = (pixel_row > section10x) && (pixel_row < section10x + section_size) && (pixel_column > section10y) && (pixel_column < section10y + section_size);
    section11 = (pixel_row > section11x) && (pixel_row < section11x + section_size) && (pixel_column > section11y) && (pixel_column < section11y + section_size);
    section12 = (pixel_row > section12x) && (pixel_row < section12x + section_size) && (pixel_column > section12y) && (pixel_column < section12y + section_size);
    section13 = (pixel_row > section13x) && (pixel_row < section13x + section_size) && (pixel_column > section13y) && (pixel_column < section13y + section_size);
    section14 = (pixel_row > section14x) && (pixel_row < section14x + section_size) && (pixel_column > section14y) && (pixel_column < section14y + section_size);
    section15 = (pixel_row > section15x) && (pixel_row < section15x + section_size) && (pixel_column > section15y) && (pixel_column < section15y + section_size);
    section16 = (pixel_row > section16x) && (pixel_row < section16x + section_size) && (pixel_column > section16y) && (pixel_column < section16y + section_size);
    section17 = (pixel_row > section17x) && (pixel_row < section17x + section_size) && (pixel_column > section17y) && (pixel_column < section17y + section_size);
    section18 = (pixel_row > section18x) && (pixel_row < section18x + section_size) && (pixel_column > section18y) && (pixel_column < section18y + section_size);
    section19 = (pixel_row > section19x) && (pixel_row < section19x + section_size) && (pixel_column > section19y) && (pixel_column < section19y + section_size);
    section20 = (pixel_row > section20x) && (pixel_row < section20x + section_size) && (pixel_column > section20y) && (pixel_column < section20y + section_size);
    section21 = (pixel_row > section21x) && (pixel_row < section21x + section_size) && (pixel_column > section21y) && (pixel_column < section21y + section_size);
    section22 = (pixel_row > section22x) && (pixel_row < section22x + section_size) && (pixel_column > section22y) && (pixel_column < section22y + section_size);
    section23 = (pixel_row > section23x) && (pixel_row < section23x + section_size) && (pixel_column > section23y) && (pixel_column < section23y + section_size);
    section24 = (pixel_row > section24x) && (pixel_row < section24x + section_size) && (pixel_column > section24y) && (pixel_column < section24y + section_size);
    section25 = (pixel_row > section25x) && (pixel_row < section25x + section_size) && (pixel_column > section25y) && (pixel_column < section25y + section_size);
    section26 = (pixel_row > section26x) && (pixel_row < section26x + section_size) && (pixel_column > section26y) && (pixel_column < section26y + section_size);
    section27 = (pixel_row > section27x) && (pixel_row < section27x + section_size) && (pixel_column > section27y) && (pixel_column < section27y + section_size);
    section28 = (pixel_row > section28x) && (pixel_row < section28x + section_size) && (pixel_column > section28y) && (pixel_column < section28y + section_size);
    section29 = (pixel_row > section29x) && (pixel_row < section29x + section_size) && (pixel_column > section29y) && (pixel_column < section29y + section_size);
    section30 = (pixel_row > section30x) && (pixel_row < section30x + section_size) && (pixel_column > section30y) && (pixel_column < section30y + section_size);
    
  end
  
  assign body_collision = head && (section4 | section5 | section6 | section7 | section8
    | section9 | section10 | section11 | section12 | section13 | section14 | section15
    | section16 | section17 | section18 | section19 | section20 | section21 | section22
    | section23 | section24 | section25 | section26 | section27 | section28 | section29
    | section30);
  
  //color
  always @(*) begin
    red = 0;
    green = 0;
    blue = 0;
    if(~gameOn) begin
      red = 1;
      blue = 1;
      green = 1;
    end else if(head || section1 || section2 || section3 || section4 || section5 || section6
    || section7 || section8 || section9 || section10 || section11 || section12 || section13
    || section14 || section15 || section16 || section17 || section18 || section19 || section20
    || section21 || section22 || section23 || section24 || section25 || section26 || section27
    || section28 || section29 || section30) begin
      green = 1;
    end else if(apple) begin
      red = 1;
    end else if(background) begin
      red = 0;
      blue = 0;
      green = 0;
    end else begin
      blue = 1;
    end
  end
  
endmodule
