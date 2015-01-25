package ValveLib.Controls
{
   import flash.media.*;
   import flash.net.*;
   import flash.events.*;
   import flash.display.*;
   
   public class VideoController extends Object
   {
      
      public function VideoController(iNumVideoStreams:int)
      {
         super();
         this.vecVideoContainer = new Vector.<MovieClip>(iNumVideoStreams);
         this.vecVideoPlaying = new Vector.<Boolean>(iNumVideoStreams);
         this.vecVideoFilename = new Vector.<String>(iNumVideoStreams);
         this.vecVideoNetStream = new Vector.<NetStream>(iNumVideoStreams);
         this.vecVideoTimeInterval = new Vector.<Number>(iNumVideoStreams);
         this.vecVideo = new Vector.<Video>(iNumVideoStreams);
         this.onStartFunc = null;
         var iVideo:* = 0;
         while(iVideo < iNumVideoStreams)
         {
            this.vecVideoContainer[iVideo] = null;
            this.vecVideoPlaying[iVideo] = false;
            iVideo++;
         }
      }
      
      private var vecVideoContainer:Vector.<MovieClip>;
      
      private var vecVideoPlaying:Vector.<Boolean>;
      
      private var vecVideoFilename:Vector.<String>;
      
      private var vecVideoNetStream:Vector.<NetStream>;
      
      private var vecVideoTimeInterval:Vector.<Number>;
      
      private var vecVideo:Vector.<Video>;
      
      private var onStartFunc:Function;
      
      public var videoWidth:int = 256;
      
      public var videoHeight:int = 256;
      
      public function startVideo(iVideo:int, videoContainer:Object, videoFileName:String) : *
      {
         if(this.vecVideoPlaying[iVideo])
         {
            if(videoFileName == this.vecVideoFilename[iVideo])
            {
               return;
            }
            this.stopVideo(iVideo);
         }
         this.vecVideoContainer[iVideo] = videoContainer as MovieClip;
         this.vecVideoFilename[iVideo] = videoFileName;
         this.vecVideo[iVideo] = new Video(this.videoWidth,this.videoHeight);
         videoContainer.visible = true;
         videoContainer.videoParent.addChild(this.vecVideo[iVideo]);
         var nc:NetConnection = new NetConnection();
         nc.connect(null);
         this.vecVideoNetStream[iVideo] = new NetStream(nc);
         this.vecVideo[iVideo].attachNetStream(this.vecVideoNetStream[iVideo]);
         (this.vecVideoNetStream[iVideo] as Object).loop = true;
         this.vecVideoNetStream[iVideo].bufferTime = 0.5;
         (this.vecVideoNetStream[iVideo] as Object).reloadThresholdTime = 0.3;
         this.vecVideoNetStream[iVideo].play(this.vecVideoFilename[iVideo]);
         this.vecVideoPlaying[iVideo] = true;
         this.vecVideoNetStream[iVideo].addEventListener(NetStatusEvent.NET_STATUS,this.VideoStatusHandler);
      }
      
      public function stopVideo(iVideo:int) : *
      {
         if(!this.vecVideoContainer[iVideo])
         {
            return;
         }
         this.vecVideoContainer[iVideo].visible = false;
         if(!this.vecVideoPlaying[iVideo])
         {
            return;
         }
         this.vecVideoPlaying[iVideo] = false;
         this.vecVideoNetStream[iVideo].close();
         if(this.vecVideo[iVideo] != null)
         {
            this.vecVideoContainer[iVideo].videoParent.removeChild(this.vecVideo[iVideo]);
            this.vecVideo[iVideo] = null;
         }
      }
      
      public function stopAllVideos() : *
      {
         var iVideo:* = 0;
         while(iVideo < this.vecVideoNetStream.length)
         {
            this.stopVideo(iVideo);
            iVideo++;
         }
      }
      
      public function restartAllVideos() : *
      {
         var iVideo:* = 0;
         while(iVideo < this.vecVideoNetStream.length)
         {
            if(this.vecVideoPlaying[iVideo])
            {
               this.vecVideoNetStream[iVideo].play(this.vecVideoFilename[iVideo]);
            }
            iVideo++;
         }
      }
      
      function checkVideoTime(ns:NetStream) : *
      {
      }
      
      public function VideoStatusHandler(event:NetStatusEvent) : void
      {
         var iVideo:* = 0;
         var iVidStarted:* = 0;
         if(event.info.code == "NetStream.Play.Stop")
         {
            iVideo = 0;
            while(iVideo < this.vecVideoNetStream.length)
            {
               if(event.target == this.vecVideoNetStream[iVideo])
               {
                  if(this.vecVideoPlaying[iVideo])
                  {
                     this.vecVideoNetStream[iVideo].play(this.vecVideoFilename[iVideo]);
                  }
               }
               iVideo++;
            }
         }
         else if(event.info.code == "NetStream.Play.Start")
         {
            if(this.onStartFunc != null)
            {
               iVidStarted = 0;
               while(iVidStarted < this.vecVideoNetStream.length)
               {
                  if(event.target == this.vecVideoNetStream[iVidStarted])
                  {
                     this.onStartFunc(iVidStarted);
                     break;
                  }
                  iVidStarted++;
               }
            }
         }
         
      }
      
      public function setOnStartFunc(func:Function) : *
      {
         this.onStartFunc = func;
      }
   }
}
