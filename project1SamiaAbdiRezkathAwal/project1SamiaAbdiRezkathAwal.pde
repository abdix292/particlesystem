// Shooting Star Project 1 CSCI 5611 
// Partners: Rezkath Awal and Samia Abdi 
// creating an image of a shooting star in the night sky 
// Key words: re-implemented means not copied, but inspired

//  Initialization of variables, objects, and arrays 
Camera camera; //for 3D camera, referenced from CSCI 5611 Camera Class by Liam Taylor 
boolean start = true; //boolean for animation start

//for star boids
float x,y; //for star positions
/* lines 12-15 re-implemented from FallingBalls.pde (Lecture 1 Example Code) */
static int numParticles = 36; //number of star boids
Vec3 pos[] = new Vec3[2*numParticles]; //position array
Vec3 vel[] = new Vec3[numParticles]; //velocity array 

//for particle systems
/* lines 18-21 and 23-26 re-implemented from FallingBalls.pde (Lecture 1 Example Code) */
int populationSize = 65000; //number of particles in fireworks, "bolt" - referenced from FallingBalls.pde (Lecture 1 Example Code)
Vec3 colorA[] = new Vec3[populationSize];//array of vectors representing color --> each vector contains RGB (mapped to x, y, z) arguments
Vec3 colorA2[] = new Vec3[populationSize];//array of vectors representing color --> each vector contains RGB (mapped to x, y, z) arguments
float radius = 60; //used for the circular emitter - reimplemented from BallLit3D.pde (Lecture 1 Example Code) 
Vec3 posArray2[] = new Vec3[populationSize]; //position array
Vec3 velArray2[] = new Vec3[populationSize]; //velocity array
Vec3 posArray3[] = new Vec3[populationSize]; //position array
Vec3 velArray3[] = new Vec3[populationSize]; //velocity array
Vec3 gravity = new Vec3(0.0, -9.8, 0.0); //gravity vector: acceleration due to gravity is -9.8 m/s/s - reference from Lecture 2 video, subtopic: Gravity, moveParticles method

PImage img, imag;  //Will store the textures we will be using - reference from spinning_textured_quad.pde (Lecture 1 Example Code)

// Setting up the start of the program 
void setup() { 
   // setting intial position of stars at top left corner of program 
   x = 0.0; 
   y = 0.0;

  /* lines 38, 42-43, and 45-46 below from spinning_textured_quad.pde (Lecture 1 Example Code) */
  size(600, 600, P3D); //600x495 3D window for quad for starlit sky texture
  surface.setTitle("Star Explosion Particle System [CSCI 5611 Project 1 by Samia Abdi and Rezkath Awal]"); // re-implemented from FallingBalls.pde (Lecture 1 Example Code)
  camera = new Camera(); //3D Camera - referenced from CSCI 5611 Camera Class by Liam Taylor 
  
  img = loadImage("starscaled.png"); //starlit sky texture
  noStroke();
  
  imag = loadImage("moon1.png"); //full moon texture
  noStroke();


  for(int t = 0; t < populationSize; t++){//reference from Lecture 2 video, subtopic: Gravity, "for loop" header from moveParticles method
    /* making circular emitter: lines 52-53, 58-59, 61-62 from Lecture 2 video, rndPos(radius) method */ 
    // randomizing polar coordinates (r,theta)
    float r = (sqrt(random(1)))*radius; //to randomize the radius in circular emitter
    float theta = 2*PI*(random(1)); //to randomize the angle in circular emitter
    
    //x component = r*sin(theta), y component = r*cos(theta), z component = r*cost(theta)
    //added values to x, y, and z components to adjust position on window
    //velArray2[] and velArray3: x, y, and z components involve randomizing velocity
    posArray2[t] = new Vec3(r*sin(theta)+100, r*cos(theta)+100, r*cos(theta) + 500 + random(50));
    velArray2[t] = new Vec3(random(100), 50 + random(100), 10 + random(80));
    
    posArray3[t] = new Vec3(r*sin(theta) + 20, r*cos(theta) + 50, r*cos(theta) + 500 + random(50));
    velArray3[t] = new Vec3(-random(800), random(800), 10 + random(80));
    
    //colorA[] and colorA2[] arrays for setting the color RGB channels for the firewords, and bolt particle systems
    /* lines 66-67 re-implemented from Lecture 2 video, subtopic: Rendering Particles, line "c = colList[i]" */
    colorA[t] = new Vec3(110, 43, 24); //Base colors: dark orange 
    colorA2[t] = new Vec3(112, 75, 65); // Base colors: brown
  }
  
  // for star boids re-implemented Boids2D program 
  for (int i = 0; i < numParticles; i++){
    pos[i] = new Vec3(200+random(100),100+random(100), random(50)); // randomized position
    vel[i] = new Vec3(random(10), random(10), random(1));  //randomized stars
  }
} 

// Drawing 
void draw(){
  /* line 80 re-implemented from FallingBalls.pde (Lecture 1 Example Code) */
  updateParticles(2.0/frameRate); //time difference dt = 2.0/frameRate
  /* line 82 referenced from 3D camera, referenced from CSCI 5611 Camera Class by Liam Taylor */
  camera.Update(1.0/frameRate); // time difference dt = 1.0/frameRate
  
  background(0);//black background behind the starlit sky texture - reimplemented from BallLit3D.pde (Lecture 1 Example Code) 
  
  //Starlit sky texture
  ///* lines 89-95 re-implemented from spinning_textured_quad.pde (Lecture 1 Example Code) */
  //We will draw the image on a quad (rectangle) made of 4 vertices
  beginShape(); 
  texture(img);
  vertex(0, 0, 0, 0, 0);//top left corner of display window
  vertex(600, 0, 0, img.width, 0); //top right corner of display window
  vertex(600, 600, 0, img.width, img.height); //bottom right corner of display window
  vertex(0, 600, 0, 0, img.height); //bottom left corner of display window
  endShape();
  
  //Red planet: 3D sphere 
  ///* lines 103-106 reimplemented from BallLit3D.pde (Lecture 1 Example Code)  */
  /* lines 100 and 107 are analog from OpenGL, re-implemented from Lecture 2 video, subtopic: Rendering Particles */
  pushMatrix(); // push new translation ontop top of stack 
  translate(160, 150); // position of the planet 
  noStroke(); //so the planet won't be colored indigo like the particles
  fill(#AF4141); //color of planet from color selector tools 
  float rad1 = 70; // radius of planet
  directionalLight(200, 200, 200, -1, 1, -1); //To change shadow of planet more realistic
  sphere(rad1); //radius of 3D sphere
  popMatrix(); // pop new translation off of stack 
  
  //Moon texture
  ///* lines 112-118 re-implemented from spinning_textured_quad.pde (Lecture 1 Example Code) */
  //We will draw the image on a quad (rectangle) made of 4 vertices
  beginShape();
  texture(imag);
  vertex(0, 0, 0, 0, 0);
  vertex(275, 0, 0, imag.width, 0);
  vertex(275, 275, 0, imag.width, imag.height);
  vertex(0, 275, 0, 0, imag.height);
  endShape();
  
  // Firework/explosion Particles 
  if(start) { // boolean true for start of animation 
  /* lines 48-54 from Rendering Particles - 36:31 of Lecture 2 video */ 
  strokeWeight(0.3); //glPointSize analog from OpenGL - sets the size of inidividual particle
  for(int i = 0; i < populationSize; i++){ 
    stroke(colorA[i].x, colorA[i].y, colorA[i].z); //glcolor3f analog from OpenGL - sets initial color of individual particle
    beginShape(POINTS); //glBegin(GL_POINTS) analog from OpenGL - starts making points
    vertex(posArray2[i].x, posArray2[i].y); //glvertex3f analog from OpenGL - draw vertex at position
    endShape(); //glEnd analog from OpenGL - this is the end of drawing the point
  }
  
  //Particles for straight "bolt" 
  /* lines 133-138 re-implemented Lecture 2 video, subtopic; Fast Rendering - Points */ 
  strokeWeight(0.4); //glPointSize analog from OpenGL - sets the size of inidividual particle
  for(int s = 0; s < populationSize; s++){
    stroke(colorA2[s].x, colorA2[s].y, colorA2[s].z); //glcolor3f analog from OpenGL - sets initial color of individual particle
    beginShape(POINTS); //glBegin(GL_POINTS) analog from OpenGL - starts making points
    vertex(posArray3[s].x, posArray3[s].y); //glvertex3f analog from OpenGL - draw vertex at position
    endShape(); //glEnd analog from OpenGL - this is the end of drawing the point
    posArray3[s].x+=95; // change the position of the bolt particles
    posArray3[s].y+=95; // change the position of the bolt particles 
  }
  
  // Start of Star Boids 
  for (int i = 0; i < 4; i++){//smallest size 
        translate(x*3,y*3); 
        fill(255, 247, 209); // color of star: cream 
        stroke(21, 27, 158); //color of star outline : indigo
        beginShape();  //beginning the shape of the stars
        // edges of stars, re-implemented from processing reference website, topic: Stars
        vertex(0, -12.5, 3.5); 
        vertex(3.5, -5, 3.5);
        vertex(11.5, -3.5, 3.5);
        vertex(5.5, 1.5, 3.5);
        vertex(7.5, 10, 3.5);
        vertex(0, 6.5, 3.5);
        vertex(-7.5, 10, 3.5);
        vertex(-5.5, 1.5, 3.5);
        vertex(-11.5, -3.5, 3.5);
        vertex(-3, -5, 3.5);
        endShape(CLOSE); // end 
  }
    //changing position of stars to move diagonally 
    x+=1; 
    y+=1;
    
    for (int i = 0; i < 4; i++){//smaller size
        translate(x*3,y*3);
        fill(255, 238, 156); // color of star: slightly darker cream color
        stroke(21, 27, 158); //color of the star outline: indigo 
        beginShape(); //beginning the shape of the stars
        // edges of stars, re-implemented from processing reference website, topic: Stars
        vertex(0, 1.5*-12.5, 3.5);
        vertex(1.5*3.5, 1.5*-5, 3.5);
        vertex(1.5*11.5, 1.5*-3.5, 3.5);
        vertex(1.5*5.5, 1.5*1.5, 3.5);
        vertex(1.5*7.5, 1.5*10, 3.5);
        vertex(0, 1.5*6.5, 3.5);
        vertex(1.5*-7.5, 1.5*10, 3.5);
        vertex(1.5*-5.5, 1.5*1.5, 3.5);
        vertex(1.5*-11.5, 1.5*-3.5, 3.5);
        vertex(1.5*-3, 1.5*-5, 3.5);
        endShape(CLOSE);
  }
  //changing position of stars to move diagonally 
    x+=1;
    y+=1;
  
   for (int i = 0; i < 4; i++){//medium size
        translate(x*3,y*3);
        fill(255, 234, 128); // color of star: yellow
        stroke(21, 27, 158); // color of star outline: indigo
        beginShape(); //beginning the shape of the stars
        // edges of stars, re-implemented from processing reference website, topic: Stars 
        vertex(0, -25, 3.5);
        vertex(7, -10, 3.5);
        vertex(23, -7, 3.5);
        vertex(11, 3, 3.5);
        vertex(15, 20, 3.5);
        vertex(0, 13, 3.5);
        vertex(-15, 20, 3.5);
        vertex(-11, 3, 3.5);
        vertex(-23, -7, 3.5);
        vertex(-6, -10, 3.5);
        endShape(CLOSE);
  }
  //changing position of stars to move diagonally 
    x+=1;
    y+=1;
    
    for (int i = 0; i < 4; i++){//largest size
        translate(x*3,y*3);
        fill(255, 230, 105);  // color of star: dark yellow
        stroke(21, 27, 158);  // color of star outline: indigo 
        beginShape(); // beginning the shape of the stars 
        // edges of stars, re-implemented from processing reference website, topic: Stars
        vertex(0, 3*-12.5, 3.5);
        vertex(3*3.5, 3*-5, 3.5);
        vertex(3*11.5, 3*-3.5, 3.5);
        vertex(3*5.5, 3*1.5, 3.5);
        vertex(3*7.5, 3*10, 3.5);
        vertex(3*0, 3*6.5, 3.5);
        vertex(3*-7.5, 3*10, 3.5);
        vertex(3*-5.5,3*1.5, 3.5);
        vertex(3*-11.5, 3*-3.5, 3.5);
        vertex(3*-3, 3*-5, 3.5);
        endShape(CLOSE);
  }
  // changing the position of stars to move diagonally 
    x+=1;
    y+=1;
  } //closing start animation bracket 
}

// lines 235-244, 246-249 re-implemented CSCI 5611 Camera Class by Liam Taylor 
void keyPressed()
{
 camera.HandleKeyPressed();
   if(key == BACKSPACE){ // backspace == animation pauses 
      noLoop();
   }
   else if(key==ENTER){ // enter == animation continues 
     loop(); 
   }
}

void keyReleased()
{
 camera.HandleKeyReleased();
}

// mouse click to restart animation 
void mouseClicked() {//line 252 referenced from CSCI 5611 Camera Class by Liam Taylor
  //start at top left corner
  x= 0;
  y= 0;
  start = true; // start condition is true for draw function - star boids 
  
  // In order for particle system to start again when mouse is clicked 
  /* lines 260-277 copied from setup() function above */
 for(int t = 0; t < populationSize; t++){
    // randomizing polar coordinates (r,theta)
    float r = (sqrt(random(1)))*radius; //to randomize the radius in circular emitter
    float theta = 2*PI*(random(1)); //to randomize the angle in circular emitter
    
    //x component = r*sin(theta), y component = r*cos(theta), z component = r*cost(theta)
    //added values to x, y, and z components to adjust position on window
    //velArray2[] and velArray3: x, y, and z components involve randomizing velocity
    posArray2[t] = new Vec3(r*sin(theta)+100, r*cos(theta)+100, r*cos(theta) + 500 + random(50));
    velArray2[t] = new Vec3(random(100), 50 + random(100), 10 + random(80));
    
    posArray3[t] = new Vec3(r*sin(theta) + 20, r*cos(theta) + 50, r*cos(theta) + 500 + random(50));
    velArray3[t] = new Vec3(-random(800), random(800), 10 + random(80));
    
    //colorA[] and colorA2[] arrays for setting the color RGB channels for the firewords, and bolt particle systems
    colorA[t] = new Vec3(110, 43, 24); //Base colors: dark orange 
    colorA2[t] = new Vec3(112, 75, 65); // Base colors: brown
 }
}

/* lines 282, 284-285 re-implemented from Lecture 2 video, subtopic: Gravity, moveParticles method */
void updateParticles(float dt){ 
  for(int i = 0; i < populationSize; i++){
      //for "bolt" particles
      posArray3[i] = posArray3[i].minus(velArray3[i].times(dt));//modeled off of s(t) = s0 + v0*dt
      velArray3[i] = cross(velArray3[i], velArray3[i].minus(gravity.times(dt))); //v(t) = v0 + g*dt
      
      //for vector rotation
      float phi = atan(posArray3[i].y/posArray3[i].x); //phi is the angle that the posArray[] vector makes with the horizontal
      
      //values in 2x2 rotational matrix 
      float one = cos(phi); //top left entry in 2 x 2 rotational matrix
      float three = sin(phi); // bottom left entry in 2 x 2 rotational matrix
      float two = -three; //top right entry in 2 x 2 rotational matrix
       
      posArray3[i].x = (one*(posArray3[i].x) + two*(-posArray3[i].y)); //modeled off of x coordinate that results from multiplying rotational matrix by [x, y] column matrix
      posArray3[i].y = (three*(-posArray3[i].x) + one*(-posArray3[i].y)); //modeled off of y coordinate that results from multiplying rotational matrix by [x, y] column matrix
    
      //mimic linear interpolation for "fireworks" particles
      /* line 299 re-implemented from Lecture 2 video, subtopic: Gravity, moveParticles method */
      posArray2[i] = posArray2[i].minus(velArray2[i].times(-dt)); // position of fireworks particle; in order to move down (-dt); //modeled off of s(t) = s0 + v0*t
      
      //odd values of i would add the colors in colorA[] and colorA2[], even values of i would add a linear combination of the two arrays
      /* lines 305-307 re-implemented from Lecture 2 video, subtopic: Gravity, moveParticles method */
      if(i%2 == 0){//even values of i
        colorA[i] = colorA[i].plus(colorA2[i].times(0.5)); //Add a linear combination of the colorA[] and colorA2[] arrays
      }else{//odd values of i
        colorA2[i] = colorA[i].plus(colorA2[i]); //Add the colorA[] and colorA2[] arrays
      }
  }
}
