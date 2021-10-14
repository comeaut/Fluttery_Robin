float x_bird;
float y_bird;
float speed_bird;

int score=0;
boolean start_button=false;

Wall wall; //Wall object.

void instructions() {//Displays instructions on inital page.
  stroke(0);
  fill(250, 195, 49);
  triangle(x_bird+10-10, y_bird+10-305, x_bird+10-10, y_bird-10-305, x_bird+40-10, y_bird-305);
  
  fill(204, 85, 0);
  circle(x_bird-10, y_bird-305, 45);
  
  stroke(255);
  fill(0);
  circle(x_bird+10-10, y_bird-10-305, 10);
  
  fill(0);
  textMode(CENTER);
  textAlign(CENTER,CENTER);
  textSize(40);
  text("Fluttery Robin", width/2, height/8-30);
  textSize(20);
  text("INSTRUCTIONS:",width/2,height/8+30);
  text("Click to make the bird fly up." ,width/2,height/8+60);
  text("The bird will fall when the mouse is not clicked." ,width/2,height/8+90);
  text("Walls will appear on the screen, try to fly through them.",width/2,height/8+120);
  text("You gain one point for each wall you fly through.",width/2,height/8+150);
  text("If you hit a wall or the bottom of the screen, it's game over!",width/2,height/8+180);
  text("Fly through as many walls as you can.",width/2,height/8+210);
  text("Be careful, as the speed will get faster the higher your score!",width/2,height/8+240);
}

void display_buttons() {//Draws buttons on initial page.
  stroke(0);
  rectMode(CENTER);
  fill(0, 255, 0);
  rect(width/4, 3*height/4, width/5, height/16);//Start
  fill(255, 0, 0);
  rect(3*width/4, 3*height/4, width/5, height/16);//Stop

  textAlign(CENTER);
  textMode(CENTER);
  fill(0);
  text("TAKEOFF!", width/4, 3*height/4);
  text("BACK TO NEST", 3*width/4, 3*height/4);
}

void display_bird() {//Draws robin on screen.
  stroke(0);
  fill(250, 195, 49);
  triangle(x_bird+10, y_bird+10, x_bird+10, y_bird-10, x_bird+40, y_bird);//Robin beak
  
  fill(204, 85, 0);
  circle(x_bird, y_bird, 45);//Robin head
  
  stroke(255);
  fill(0);
  circle(x_bird+10, y_bird-10, 10);//Robin eyes
}

void move_bird() {//Robin movement behaviors.
  speed_bird=8;
  y_bird=y_bird+speed_bird;//Robin moves down unless the mouse is pressed.

  if (mousePressed) {
    y_bird=y_bird-20;//When the mouse is pressed, the robin moves up.
    y_bird=constrain(y_bird,45/2,height+10);//Keep bird inside the window.
  }
}

boolean check_bird_hit_bottom() {//Ends game if robin hits bottom of window.
  if (y_bird>=height) {
    textSize(100);
    textMode(CENTER);
    textAlign(CENTER);
    fill(0);
    text("GAME OVER", width/2, height/2);
    stop();
    return true;
  } 
  return false;
}

void display_score() {//Displays the score in the top left of window.
  fill(0);
  textSize(16);
  text(score+" POINTS", width/8, height/8);
}

void display_clouds(){//Draws cloud scenery.
  int gap_cloud=100;
  
  //Loop to draw several clouds on screen as scenery.
  for(int x_cloud=0; x_cloud<=width; x_cloud=x_cloud+gap_cloud){
    fill(255);
    //Upper clouds
    circle(x_cloud-20,height/4,50);
    circle(x_cloud+20,height/4,50);
    circle(x_cloud,height/4-30,50);
    
    //Middle clouds
    circle(x_cloud+gap_cloud/2-20,height/2,50);
    circle(x_cloud+gap_cloud/2+20,height/2,50);
    circle(x_cloud+gap_cloud/2,height/2-30,50);
    
    //Lower clouds
    circle(x_cloud-20,3*height/4,50);
    circle(x_cloud+20,3*height/4,50);
    circle(x_cloud,3*height/4-30,50);
  }
}


void setup() {
  size(750, 750); 
  x_bird=width/4;
  y_bird=height/2;

  wall=new Wall();
  wall.random_pick_wall();
}

void draw() {
  background(135, 206, 235);
  display_buttons();
  instructions();

  if (!start_button && mouseX>=(3*width/4-width/10) && mouseX<=(3*width/4+width/10) && mouseY>=(3*height/4-height/32) && mouseY<=(3*height/4+height/32) && mousePressed) {
    exit();//Exit game when quit button is pressed.
    //!start_button significance - Once start button is pressed, quit button will disappear, this makes sure that clicking where it used to be will not stop the game.
  }

  if (mouseX>=(width/4-width/10) && mouseX<=(width/4+width/10) && mouseY>=(3*height/4-height/32) && mouseY<=(3*height/4+height/32) && mousePressed) {
    start_button=!start_button;//Start button serves as a "toggle" button - it only needs to be pressed once.
    start_button=true;//Makes sure the start button can not be pressed again once in the game.
  }
  if (start_button) {//Begins the game when start button is pressed.
    
  background(135, 206, 235);//Covers initial page (makessure its not visible) after button is pressed.
  display_clouds();
  
  display_bird();
  move_bird();
  
  wall.display_wall();
  wall.move_wall();
  check_bird_hit_bottom();
  wall.check_bird_hit_wall();
  wall.check_bird_through_wall();

  display_score();
  }
}
