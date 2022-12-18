class Line {
  PVector start, end;
  float minX, minY, maxX, maxY;
  Line(PVector start, PVector end) {
    this.start = start;
    this.end = end;
  }
  
  Line(float x, float y, float w, float h) {
    this(new PVector(x, y), new PVector(w, h));
    this.minX = x;
    this.minY = y;
    this.maxX = w;
    this.maxY = h;
  }

  boolean intersect(Line other) {
    float x1 = this.start.x;
    float y1 = this.start.y;
    float x2 = this.end.x;
    float y2 = this.end.y;
    float x3 = other.start.x;
    float y3 = other.start.y;
    float x4 = other.end.x;
    float y4 = other.end.y;
    float d = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4);
    if (d == 0) return false;
    float pre = (x1*y2 - y1*x2), post = (x3*y4 - y3*x4);
    float x = ( pre * (x3-x4) - (x1-x2) * post ) / d;
    float y = ( pre * (y3-y4) - (y1-y2) * post ) / d;
    if ( x < minX || x > maxX || x < x3 || x > x4 ) return false;
    if ( y < minY || y > maxY || y < y3 || y > y4 ) return false;
    return true;
  }

  boolean intersect(Collider other) {
    return other.intersect(this);
  }
}
