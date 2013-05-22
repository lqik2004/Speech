//
//  APSpeech.m
//
//  Created by alberto pasca on 10/04/13.
//  Copyright (c) 2013 albertopasca.it All rights reserved.
//

#import "APSpeech.h"


#define URL @"http://www.translate.google.com/translate_tts?tl=%@&q=%@"
#define UA  @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7.5; rv:2.0.1) Gecko/20100101 Firefox/4.1.2"


@interface APSpeech ()
{
  float _Volume;
  int   _Loop;

  AVAudioPlayer *_Player;
}
@end


@implementation APSpeech
@synthesize Volume=_Volume, Loop=_Loop;

- (id) init
{
  if ( self = [super init] )
  {
    _Volume = 0.4f;
    _Loop   = 0;
  }
  
  return self;
}

- (NSString*) getLanguage:(APSpeechLanguage)lang
{
  switch (lang) {
    case APSpeechLanguageITA: return @"it";
    case APSpeechLanguageENG: return @"en";
    case APSpeechLanguageFRE: return @"fr";
    case APSpeechLanguageDEU: return @"de";
    case APSpeechLanguageESP: return @"es";
    case APSpeechLanguageCHN: return @"zh-CN";
    default: return @"it";
  }
}

- (APSpeechStatus) SpeechThis:(NSString*)text inLanguage:(APSpeechLanguage)lang
{
  NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *path = [documentsDirectory stringByAppendingPathComponent:@"currentSpeech.mp3"];
  
  
  NSString *urlString = [NSString stringWithFormat:URL, [self getLanguage:lang], text];
  
  NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
  
  [request setValue:UA forHTTPHeaderField:@"User-Agent"];
  
  NSURLResponse* response = nil;
  NSError* error = nil;
  
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if ( error ) return APSpeechStatusKo;
  
  [data writeToFile:path atomically:YES];
  
  NSError *err;
  if ( [[NSFileManager defaultManager] fileExistsAtPath:path] )
  {
    if ( _Player && [_Player isPlaying] ) {
      [_Player stop];
      [_Player release];
      _Player = nil;
    }

    _Player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&err];

    if ( error ) return APSpeechStatusKo;

    _Player.volume = _Volume;
    [_Player prepareToPlay];
    [_Player setNumberOfLoops:_Loop];
    [_Player play];

    return APSpeechStatusOk;
  }

  return APSpeechStatusKo;
}


@end

