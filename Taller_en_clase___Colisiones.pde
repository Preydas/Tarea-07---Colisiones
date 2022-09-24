int numPelotas = 4;
float resorte = 0.05;
float gravedad = 0.09;
float friccion = -0.9;
Ball[] pelotas = new Ball[numPelotas];

void setup() {
  size(640, 360);
  for (int i = 0; i < numPelotas; i++) {
    pelotas[i] = new Ball(random(width), random(height), random(30, 70), i, pelotas);
  }
  noStroke();
  fill(0, 128, 128);
}

void draw() {
  background(0);
  for (Ball ball : pelotas) {
    ball.collide();
    ball.move();
    ball.display();  
  }
}

class Ball {
  
  float x, y;
  float diametro;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] otros;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diametro = din;
    id = idin;
    otros = oin;
  } 
  
  void collide() {
    for (int i = id + 1; i < numPelotas; i++) {
      float dx = otros[i].x - x;
      float dy = otros[i].y - y;
      float distancia = sqrt(dx*dx + dy*dy);
      float minDist = otros[i].diametro/2 + diametro/2;
      if (distancia < minDist) { 
        float angulo = atan2(dy, dx);
        float targetX = x + cos(angulo) * minDist;
        float targetY = y + sin(angulo) * minDist;
        float ax = (targetX - otros[i].x) * resorte;
        float ay = (targetY - otros[i].y) * resorte;
        vx -= ax;
        vy -= ay;
        otros[i].vx += ax;
        otros[i].vy += ay;
      }
    }   
  }
  
  void move() {
    vy += gravedad;
    x += vx;
    y += vy;
    if (x + diametro/2 > width) {
      x = width - diametro/2;
      vx *= friccion; 
    }
    else if (x - diametro/2 < 0) {
      x = diametro/2;
      vx *= friccion;
    }
    if (y + diametro/2 > height) {
      y = height - diametro/2;
      vy *= friccion; 
    } 
    else if (y - diametro/2 < 0) {
      y = diametro/2;
      vy *= friccion;
    }
  }
  
  void display() {
    ellipse(x, y, diametro, diametro);
  }
}
