public class ShapeUtils {

  public ShapeUtils() {
  }

  //returns min x coordinate of a given PShape
  public float getMinX(PShape shape) {
    float minX = shape.getVertex(0).x;
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector vector = shape.getVertex(i);
      minX = Math.min(minX, vector.x);
    }
    return minX;
  }
  
  //returns max x coordinate of a given PShape
  public float getMaxX(PShape shape) {
    float maxX = 0;
    for (int i = 0; i < shape.getVertexCount(); i++) {
      PVector vector = shape.getVertex(i);
      maxX = Math.max(maxX, vector.x);
    }
    return maxX;
  }
  
  //returns max y coordinate of a given PShape
  public float getMaxY(PShape shape){
    float maxY = 0;
    for(int i = 0; i < shape.getVertexCount(); i++){
      PVector vector = shape.getVertex(i);
      maxY = Math.max(maxY, vector.y);
    }
    return maxY;
  }
  
  //return min y coordinate of a given PShape
  public float getMinY(PShape shape){
    float minY = shape.getVertex(0).y;
    for(int i = 0; i < shape.getVertexCount(); i++){
      PVector vector = shape.getVertex(i);
      Math.min(minY, vector.y);
    }
    return minY;
  }
  
  
  // returns width of a given PShape
  public float getWidth(PShape shape){
    return (getMaxX(shape) - getMinX(shape));
  }
  
  //returns height of a given PShape
  public float getHeight(PShape shape){
    return (getMaxY(shape) - getMinY(shape));
  }
}
