int[][] grid = new int[20][20];
int[][] reached = new int[20][20];
int[][][] prior = new int[20][20][2];
int[] startNodePos = new int[2];
int[] endNodePos = new int[2];
ArrayList<int[]> layer = new ArrayList<int[]>();
ArrayList<int[]> path = new ArrayList<int[]>();
int timer = 0;
int startNode = 0;
int endNode = 0;
int start = 0;

void setup() {
 size(1000,1100);
 startNodePos[0] = -1;
 startNodePos[1] = -1;
 endNodePos[0] = -1;
 endNodePos[1] = -1;
}

void clear(){
 layer = new ArrayList<int[]>();
 path = new ArrayList<int[]>();
 timer = 0;
 startNode = 0;
 endNode = 0;
 start = 0;
 startNodePos[0] = -1;
 startNodePos[1] = -1;
 endNodePos[0] = -1;
 endNodePos[1] = -1;
 for(int i = 0; i < 20;i ++){
  for(int j = 0; j < 20; j++){
    grid[i][j] = 0;
    reached[i][j] = 0; 
    prior[i][j][0] = 0;
    prior[i][j][1] = 0;
  }
 }
}

void bfs(){
 if(reached[startNodePos[0]][startNodePos[1]] == 0){
   layer.add(startNodePos);
   reached[startNodePos[0]][startNodePos[1]] = 1;
   prior[startNodePos[0]][startNodePos[1]][0] = startNodePos[0];
   prior[startNodePos[0]][startNodePos[1]][1] = startNodePos[1];
  }
 if(layer.size() != 0 && reached[endNodePos[0]][endNodePos[1]] == 0){
  ArrayList<int[]> tempLayer = new ArrayList<int[]>();
  for(int[] pos : layer){
    int x = pos[0];
    int y = pos[1];
    if(x > 0 && grid[x-1][y] == 0 && reached[x-1][y] == 0){
     tempLayer.add(new int[]{x-1,y}); 
     reached[x-1][y] = 1;
     prior[x-1][y][0] = x;
     prior[x-1][y][1] = y;
    }
    if(x < 19 && grid[x+1][y] == 0 && reached[x+1][y] == 0){
     tempLayer.add(new int[]{x+1,y}); 
     reached[x+1][y] = 1;
     prior[x+1][y][0] = x;
     prior[x+1][y][1] = y;
    }
    if(y > 0 && grid[x][y-1] == 0 && reached[x][y-1] == 0){
     tempLayer.add(new int[]{x,y-1}); 
     reached[x][y-1] = 1;
     prior[x][y-1][0] = x;
     prior[x][y-1][1] = y;
    }
    if(y < 19 && grid[x][y+1] == 0 && reached[x][y+1] == 0){
     tempLayer.add(new int[]{x,y+1}); 
     reached[x][y+1] = 1;
     prior[x][y+1][0] = x;
     prior[x][y+1][1] = y;
    }
  }
  layer = tempLayer;
 }
 if(reached[endNodePos[0]][endNodePos[1]] != 0){
   int[] tempPos = new int[]{prior[endNodePos[0]][endNodePos[1]][0], prior[endNodePos[0]][endNodePos[1]][1]};
   while(tempPos[0] != startNodePos[0] || tempPos[1] != startNodePos[1]){
     path.add(new int[]{tempPos[0], tempPos[1]});
     int x = prior[tempPos[0]][tempPos[1]][0];
     int y = prior[tempPos[0]][tempPos[1]][1];
     tempPos[0] = x;
     tempPos[1] = y;
   }
 }
}

void draw(){
  if(endNodePos[0] != -1 && reached[endNodePos[0]][endNodePos[1]] != 0){
    fill(100,0,100);
    for(int[] arr : path){
      rect(arr[0]*50, arr[1]*50, 50, 50); 
    }
  }
  else{
  //clear background
  background(0);
  
  //set drawing color to white
  fill(255);
  
  //generate selection rectangles
  if(startNode != 0){
   fill(0); 
   rect(0,1000,350,100);
   fill(255);
  }
  else{
  rect(0,1000,350,100);
  }
  rect(350,1000,300,100);
  if(endNode != 0){
    fill(0);
    rect(650,1000,350,100);
    fill(255);
  }
  else{
  rect(650,1000,350,100);
  }
  
  //generate selection text (start node, start, end node)
  textSize(100);
  fill(0, 102, 153);
  if(start == 1){
   text("Reset", 375, 1090);
  }
  else{
   text("Start", 390, 1090);
  }
  textSize(65);
  text("Start Node", 10, 1090);
  text("End Node", 675, 1090);
  
  //generate grid
  fill(255);
  for(int i = 0; i < 20;i ++){
  for(int j = 0; j < 20; j++){
    if(grid[i][j] == 0 && reached[i][j] == 0){
     rect(i*50,j*50, 50,50); 
    }
  }
 }
 fill(0,0,255);
 for(int i = 0; i < 20;i ++){
  for(int j = 0; j < 20; j++){
    if(reached[i][j] != 0){
     rect(i*50,j*50, 50,50); 
    }
  }
 }
 fill(0,255,0);
 if(startNodePos[0] != -1){
  rect(startNodePos[0]*50, startNodePos[1]*50, 50, 50);
 }
 fill(255,0,0);
 if(endNodePos[0] != -1){
  rect(endNodePos[0]*50, endNodePos[1]*50, 50, 50);
 }
 if(timer > 60){
   timer = 0;
   bfs();
 }
 else if(start == 1){
   timer++;
 }
  }
}

void startButton(){
  if(start == 0 && startNodePos[0] != -1 && endNodePos[0] != -1){
   start = 1;
   bfs();
  }
  else{
   clear(); 
  }
}

void startNode(){
  if(startNode == 0){
   startNode = 1;
   endNode = 0;
  }
  else{
   startNode = 0; 
  }
}

void endNode(){
  if(endNode == 0){
   endNode = 1;
   startNode = 0;
  }
  else{
   endNode = 0; 
  }
}

void mouseClicked(){
  if(mouseY >= 1000){
    if(mouseX <= 350){
      startNode();
    }
    else if(mouseX <= 650){
      startButton();
    }
    else if(mouseX <= 1000){
      endNode();
    }  
  }
  else{
   int x = mouseX - (mouseX % 50); 
   int y = mouseY - (mouseY % 50);
   x = x/50;
   y = y/50;
   if(startNode == 1){
    if(x == startNodePos[0] && y == startNodePos[1]){
     startNodePos[0] = -1;
     startNodePos[1] = -1;
    }
    else{
    startNodePos[0] = x;
    startNodePos[1] = y;
    }
   }
   else if(endNode == 1){
    if(x == endNodePos[0] && y == endNodePos[1]){
     endNodePos[0] = -1;
     endNodePos[1] = -1;
    }
    else{
    endNodePos[0] = x;
    endNodePos[1] = y;
    }
   }
   else{
   if(grid[x][y] == 0){
     grid[x][y] = 1;
   }
    else{
      grid[x][y] = 0; 
    }
   }
  }
}
