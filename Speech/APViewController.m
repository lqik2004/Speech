//
//  APViewController.m
//  Speech
//
//  Created by alberto pasca on 10/04/13.
//  Copyright (c) 2013 albertopasca.it. All rights reserved.
//

#import "APViewController.h"
#import "APSpeech.h"


@implementation APViewController

- (void)viewDidLoad
{
  [super viewDidLoad];


  APSpeech *Speech = [[APSpeech alloc] init];

  Speech.Volume = 0.9;  // optional, default 0.4
  Speech.Loop   = 2;    // optional, default 0

  [Speech SpeechThis:@"你好，世界" inLanguage:APSpeechLanguageCHN];

  [Speech release];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void) dealloc
{
  [super dealloc];
}

@end
