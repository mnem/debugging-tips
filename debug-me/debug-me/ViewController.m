//
//  ViewController.m
//  debug-me
//
//  Created by David Wagner on 05/04/2016.
//  Copyright © 2016 David Wagner. All rights reserved.
//

#import "ViewController.h"

static NSString * const JSONEndpoint = @"http://localhost:12345/index.json";
static NSString * const PNGEndpoint = @"http://localhost:12345/index.png";

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

NS_ASSUME_NONNULL_BEGIN

@implementation ViewController

- (void)disableButtons {
    for (UIButton *button in self.buttons) {
        button.enabled = NO;
    }
}

- (void)enableButtons {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIButton *button in self.buttons) {
            button.enabled = YES;
        }
    });
}

- (void)fetchContentFrom:(NSString *)endpoint completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:endpoint]
                                        completionHandler:completionHandler];
    [task resume];
}

- (IBAction)handleFetchJSONTapped:(UIButton *)sender {
    [self disableButtons];
    [self fetchContentFrom:JSONEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Response: %@", response);
        [self enableButtons];
    }];
}

- (IBAction)handleFetchPNGTapped:(UIButton *)sender {
    [self disableButtons];
    [self fetchContentFrom:PNGEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Response: %@", response);
        [self enableButtons];
    }];
}

@end

NS_ASSUME_NONNULL_END
