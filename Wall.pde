class Wall {//Class for the walls that move from right to left.

  float x_wall;
  float y_wall;
  float gap_wall=90;
  float speed_wall;

  Wall() {
  }

  void random_pick_wall() {
    x_wall=width;
    y_wall=(int)random(50, height-50);//The location of thr gap in the walls is random.
  }

  void display_wall() {
    rectMode(CENTER);
    stroke(0);
    fill(185, 180, 171);
    rect(x_wall, y_wall-5*height/12-gap_wall, 30, 5*height/6);
    rect(x_wall, y_wall+5*height/12+gap_wall, 30, 5*height/6);
  }

  void move_wall() {
    speed_wall=-4-(0.25*score);//Walls move faster as score increases.
    x_wall=x_wall+speed_wall;
  }

  boolean check_bird_hit_wall() {//When the bird hits the wall, the game ends.
    if (x_bird>=x_wall-15 && x_bird<=x_wall+15) {
      if (y_bird<=y_wall-gap_wall || y_bird>=y_wall+gap_wall) {
        textSize(100);
        textMode(CENTER);
        textAlign(CENTER);
        fill(0);
        text("GAME OVER", width/2, height/2);
        stop();
        return true;
      }
    }
    return false;
  }

  boolean check_bird_through_wall() {//When the bird gets through the walls, one point is gained.
    if (x_bird>=x_wall+15) {
      if (y_bird>=y_wall-gap_wall || y_bird<=y_wall+gap_wall) {
        random_pick_wall();
        x_wall=width;
        score++;
        return true;
      }
    }
    return false;
  }
}
