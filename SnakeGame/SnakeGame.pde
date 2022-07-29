
    /*
     * Game variables
     * 
     * Put all the game variables here.
     */
       Segment head;
      int foodX;
      int foodY;
      ArrayList<Segment> tails = new ArrayList<Segment>();
      
    class Segment {
    int x;
    int y;
    Segment(int x, int y){
      this.x=x;
      this.y=y;
    }
    
}
  int direction = UP;
  int food = 0;
    /*
     * Setup methods
     * 
     * These methods are called at the start of the game.
     */

    public void setup() {
         size(500,500);
      head = new Segment(300,300);
        frameRate(20);
        dropFood();
    }

    void dropFood() {
        // Set the food in a new random location
      foodX = ((int)random(50)*10);
      foodY = ((int)random(50)*10);
    }

    /*
     * Draw Methods
     * 
     * These methods are used to draw the snake and its food
     */

    @Override
    public void draw() {
        background(25,50,100);
        drawFood();
        move();
        drawSnake();
        eat();
        drawTail();
        
    }

    void drawFood() {
        // Draw the food
 
        fill(255,0,0);
        rect(foodX,foodY,10,10);
    }

    void drawSnake() {
        // Draw the head of the snake followed by its tail
      fill(0,0,255);
      rect(head.x,head.y,10,10);
      manageTail();
    }

    void drawTail() {
        // Draw each segment of the tail
        for(int i = 0; i < tails.size(); i++){
         fill(0,255,0);
          Segment j = tails.get(i);
          rect(j.x,j.y,10,10);
      
        }
    }

    /*
     * Tail Management methods
     * 
     * These methods make sure the tail is the correct length.
     */

    void manageTail() {
        // After drawing the tail, add a new segment at the "start" of the tail and
        // remove the one at the "end"
        // This produces the illusion of the snake tail moving.
         checkTailCollision();
         drawTail();
         Segment piece = new Segment(head.x,head.y);
           tails.add(piece);
           tails.remove(0);
    }

    void checkTailCollision() {
        // If the snake crosses its own tail, shrink the tail back to one segment
        for(int i = 0; i < tails.size(); i++){
           Segment j = tails.get(i);
           if(j.x==head.x && j.y==head.y){
             food = 1;
             tails = new ArrayList<Segment>();
             for(int k = 0; k < tails.size(); k++){
           Segment m = tails.get(k);
           m.x = head.x;
           m.y = head.y;
           
         }
           }
        }
    }

    /*
     * Control methods
     * 
     * These methods are used to change what is happening to the snake
     */

    @Override
    public void keyPressed() {
        // Set the direction of the snake according to the arrow keys pressed
        if (key == CODED) {
          if(keyCode == UP && direction!=DOWN) {
             direction=UP;
          }
        }
        if(key == CODED) {
         if(keyCode == LEFT && direction!=RIGHT){
           direction=LEFT;
         }
        }
        if(key == CODED) {
         if(keyCode == RIGHT && direction!=LEFT){
           direction=RIGHT;
         }
        }
        if(key == CODED) {
         if(keyCode == DOWN && direction!=UP){
           direction=DOWN;
         }
        }
    }

    void move() {
        // Change the location of the Snake head based on the direction it is moving.

        
        if (direction == UP) {
            // Move head up
            head.y-=10;
        } else if (direction == DOWN) {
            // Move head down
            head.y+=10;
        } else if (direction == LEFT) {
            head.x-=10;
        } else if (direction == RIGHT) {
            head.x+=10;
        }
        checkBoundaries();
    }

    void checkBoundaries() {
        // If the snake leaves the frame, make it reappear on the other side
        if(head.y<0){
          head.y=500;
        }
        if(head.x<0){
         head.x=500; 
        }
        if(head.y>500){
          head.y=0;
        }
        if(head.x>500){
         head.x=0; 
        }
    }
    void eat() {
        // When the snake eats the food, its tail should grow and more
        // food appear
        if(head.x==foodX&&head.y==foodY){
          food++;
          dropFood();
          Segment piece = new Segment(head.x, head.y);
          tails.add(piece);
        }
         
        }
    
