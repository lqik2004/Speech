//
//  APSpeech.h
//
//  Created by alberto pasca on 10/04/13.
//  Copyright (c) 2013 albertopasca.it All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


typedef enum {
  APSpeechStatusOk = 0,
  APSpeechStatusKo
} APSpeechStatus;

typedef enum {
  APSpeechLanguageITA = 0,
  APSpeechLanguageENG,
  APSpeechLanguageFRE,
  APSpeechLanguageDEU,
  APSpeechLanguageESP,
  APSpeechLanguageCHN
} APSpeechLanguage;


@interface APSpeech : NSObject

@property (nonatomic, assign) float Volume;
@property (nonatomic, assign) int   Loop;

- (APSpeechStatus) SpeechThis:(NSString*)text inLanguage:(APSpeechLanguage)lang;

@end
