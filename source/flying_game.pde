import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*; 

PImage space;
Minim minim;
    AudioPlayer qupa0,qupa1,qupa2,qupaX;
    
    ball a= new ball(); //ball関数
    pillar[] t= new pillar[3]; //柱
    boolean end=false; 
    boolean intro=true;
    int score=0;
    float  taira,ina,ri;
    void setup(){
      size(500,800);
      minim = new Minim(this); //Minim class
      qupa0 = minim.loadFile("music/jump09.mp3"); //ジャンプ
      qupa1 = minim.loadFile("music/1.01.Let's Play! Soccer.mp3"); //スタート画面
      qupa2 = minim.loadFile("music/効果音スーパーマリオ　死亡.mp3"); //ゲームオーバー
      qupaX = minim.loadFile("music/01 here we go.mp3"); //プレイング中
      qupa1.play();
      space=loadImage("NASA9.jpg");
      taira=random(256);
      ina=random(256);
      ri=random(256);
      for(int i=0;i<3;i++){
      t[i]=new pillar(i); 
    }
    }

    void draw(){
      image(space,-310,-250);
      if(end){
      a.move();
      }
      a.drawball();
      if(end){
      a.fall();
      }
      a.checkcollisions();
      for(int i=0;i<3;i++){
      t[i].drawpillar();
      t[i].checkposition();
      }
      fill(0);
      stroke(255);
      textSize(32);
      if(end){
      rect(20,20,100,50);
      fill(255,255,0);
      text(score,62,58);
      }else{
      rect(140,100,210,50);
      rect(50,200,380,50);
      fill(255);
      if(intro){
        text("Flying game",155,137);
        text("Click SPACE to Play",95,240);
      }else{
      text("game over",170,135);
      text("score",170,235);
      fill(0);
      rect(50,300,400,50);
      fill(255);
      text("click SPACE to play again",60,340);
      fill(255,255,0);
      text(score,270,237);
      }
      }
    }

    class ball{
      float xpos,ypos,ySpeed;
    ball(){
    xpos = 250;
    ypos = 400;
    }
    void drawball(){
      fill(taira,ina,ri,255/2);
      strokeWeight(2);
      ellipse(xpos,ypos,20,20);
    }
    void jump(){
     ySpeed=-10; 
    }
    void fall(){
     ySpeed+=0.5; 
    }
    void move(){
     ypos+=ySpeed; 
     for(int i=0;i<3;i++){  //スピード調整
      if(score<=10){
       t[i].xpos-=1.5;
     }
     if(score>10&&score<=20){
       t[i].xpos-=2;
     }
    if(score>20&&score<=30){
      t[i].xpos-=3;
  }
      if(score>30&&score<=40){
      t[i].xpos-=4;  
  }
        if(score>40&&score<=50){
      t[i].xpos-=5;
        }
          if(50<score){
      t[i].xpos-=6;
  }
     }
    }
    void checkcollisions(){
     if(ypos>800){ //下に当たった時
      qupaX.pause();
      end=false;
      qupa2.play();
     }
    for(int i=0;i<3;i++){ //棒に触れた時
    if((xpos<t[i].xpos+18&&xpos>t[i].xpos-18)&&(ypos<t[i].start-150||ypos>t[i].start+150)){
      qupa2.play();
      qupaX.pause(); 
      end=false;
    }
    }
    } 
    }
    class pillar{
      float xpos,start;
      boolean  saved= false;
     pillar(int i){
      xpos = 100+(i*200);
      start = random(600)+150;
    }

     void drawpillar(){
       strokeWeight(8);   //棒のサイズ
       line(xpos,0,xpos,start-150);  
       line(xpos,start+150,xpos,800);
     }
     void checkposition(){
      if(xpos<0){
       xpos+=(200*3);
       start = random(600)+150;
        saved = false;
      } 
      if(xpos<250&&saved==false){
       saved = true;
       score++;     
      }
     }

    }
    void reset(){  
     end=true;
     score=0;
     a.ypos=400;
     qupaX.play();
     qupaX.rewind();
     for(int i = 0;i<3;i++){
      t[i].xpos+=550;
      t[i].saved = false;
     }
    }
    
    void keyPressed(){
     if(key==' '){
     a.jump();
     qupa1.close();
     qupaX.play(); 
     qupa0.play();
     qupa0.rewind();
     intro=false;
     }
     if(end==false){
       reset();
     }
    }
