//Vector Library [2D]
//CSCI 5611 Vector 3 Library [Incomplete]

//Instructions: Add 3D versions of all of the 2D vector functions
//              Vec3 must also support the cross product.
public class Vec3 {
  public float x, y, z;
  
  public Vec3(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public String toString(){
    return "(" + x+ ", " + y+ ", " + z+")";
  }
  
  public float length(){
    float squareXComp = x*x;
    float squareYComp = y*y;
    float squareZComp = z*z;
    float sumOfSquares = squareXComp + squareYComp + squareZComp;
    return sqrt(sumOfSquares);
  }
  
  public Vec3 plus(Vec3 rhs){
    float xComp = x + rhs.x;
    float yComp = y + rhs.y;
    float zComp = z + rhs.z;
    return new Vec3(xComp,yComp,zComp);
  }
  
  public void add(Vec3 rhs){
    x = x + rhs.x;
    y = y + rhs.y;
    z = z + rhs.z;
  }
  
  public Vec3 minus(Vec3 rhs){
    float xComp = x - rhs.x;
    float yComp = y - rhs.y;
    float zComp = z - rhs.z;
    return new Vec3(xComp,yComp,zComp);
  }
  
  public void subtract(Vec3 rhs){
    x = x - rhs.x;
    y = y - rhs.y;
    z = z - rhs.z;
  }
  
  public Vec3 times(float rhs){
    float xComp = x*rhs;
    float yComp = y*rhs;
    float zComp = z*rhs;
    return new Vec3(xComp,yComp,zComp);
  }
  
  public void mul(float rhs){
    x = x*rhs;
    y = y*rhs;
    z = z*rhs;
  }
  
  public void normalize(){
    float squareXComp = x*x;
    float squareYComp = y*y;
    float squareZComp = z*z;
    float sumOfSquares = squareXComp + squareYComp + squareZComp;
    float l = sqrt(sumOfSquares);
    x = x/l;
    y = y/l;
    z = z/l;
  }
  
  public Vec3 normalized(){
    float squareXComp = x*x;
    float squareYComp = y*y;
    float squareZComp = z*z;
    float sumOfSquares = squareXComp + squareYComp + squareZComp;
    float l = sqrt(sumOfSquares);
    float x1 = x/l;
    float y1 = y/l;
    float z1 = z/l;
    return new Vec3(x1, y1, z1);
  }
  
  public float distanceTo(Vec3 rhs){
    float squareXComp = (rhs.x - x)*(rhs.x - x);
    float squareYComp = (rhs.y - y)*(rhs.y - y);
    float squareZComp = (rhs.z - z)*(rhs.z - z);
    float sumOfSquares = squareXComp + squareYComp + squareZComp;
    return sqrt(sumOfSquares);
  }
}

Vec3 interpolate(Vec3 a, Vec3 b, float t){
  float xComp = a.x + ((b.x-a.x)*t);
  float yComp = a.y + ((b.y-a.y)*t);
  float zComp = a.z + ((b.z-a.z)*t);
  return new Vec3(xComp,yComp,zComp); 
}

float dot(Vec3 a, Vec3 b){
  float multiplyXs = a.x*b.x;
  float multiplyYs = a.y*b.y;
  float multiplyZs = a.z*b.z;
  return (multiplyXs + multiplyYs + multiplyZs);
}

Vec3 cross(Vec3 a, Vec3 b){
  float xComp = (a.y*b.z)-(a.z*b.y);
  float yComp = (a.x*b.z)-(a.z*b.x);
  yComp *= -1;
  float zComp = (a.x*b.y)-(a.y*b.x);
  return new Vec3(xComp,yComp,zComp);
}

Vec3 projAB(Vec3 a, Vec3 b){
  b = b.times(dot(a,b));
  return new Vec3(b.x, b.y,b.z);
}
