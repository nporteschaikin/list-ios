//
//  ListUICameraController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/17/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUICameraController.h"

@interface ListUICameraController ()

@property (strong, nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCaptureDevicePosition devicePosition;

@end

@implementation ListUICameraController

- (void)initializeSession {
    
    /*
     * Find default device.
     */
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        
        /*
         * Set capture session.
         */
        
        self.session = [[AVCaptureSession alloc] init];
        
        /*
         * Create default input.
         */
        
        AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
        if ([self.session canAddInput:input]) {
            [self.session addInput:input];
        }
        
        /*
         * Create default output.
         */
        
        AVCaptureStillImageOutput *output = [[AVCaptureStillImageOutput alloc] init];
        if ([self.session canAddOutput:output]) {
            [self.session addOutput:output];
        }
        
        /*
         * Set device position.
         */
        
        self.devicePosition = device.position;
        
        /*
         * Start running session.
         */
        
        [self.session startRunning];
        
    }
    
}

- (void)captureStillImage {
    
    /*
     * Find output.
     */
    
    AVCaptureSession *session = self.session;
    NSArray *outputs = session.outputs;
    AVCaptureStillImageOutput *output = outputs.count ? outputs[0] : nil;
    if (output) {
        
        /*
         * Find connection.
         */
        
        AVCaptureConnection *connection = [output connectionWithMediaType:AVMediaTypeVideo];
        
        /*
         * Capture.
         */
        
        [output captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if (imageDataSampleBuffer) {
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                
                /*
                 * Send delegate message.
                 */
                
                if ([self.delegate respondsToSelector:@selector(cameraController:didCaptureStillImage:)]) {
                    [self.delegate cameraController:self didCaptureStillImage:image];
                }
                
            }
        }];
        
    }
    
}

- (void)toggleDevice {
    
    AVCaptureSession *session = self.session;
    NSArray *inputs = session.inputs;
    
    /*
     * Get new position.
     */
    
    AVCaptureDevice *currentDevice = inputs.count ? ((AVCaptureDeviceInput *)inputs[0]).device : nil;
    AVCaptureDevicePosition currentPosition = currentDevice.position;
    AVCaptureDevicePosition newPosition;
    
    switch (currentPosition) {
        case AVCaptureDevicePositionBack: {
            newPosition = AVCaptureDevicePositionFront;
            break;
        }
        case AVCaptureDevicePositionFront:
        case AVCaptureDevicePositionUnspecified: {
            newPosition = AVCaptureDevicePositionBack;
            break;
        }
    }
    /*
     * Get new device.
     */
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *device;
    for (AVCaptureDevice *dev in devices) {
        if (dev.position == newPosition) {
            device = dev;
            break;
        }
    }
    
    /*
     * Only move forward if we have a device.
     */
    
    if (device) {
        
        /*
         * Remove existing input.
         */
        
        if (inputs.count) {
            [session removeInput:inputs[0]];
        }
        
        /*
         * Add new input.
         */
        
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        if ([session canAddInput:deviceInput]) {
            [session beginConfiguration];
            [session addInput:deviceInput];
            [session commitConfiguration];
            
            /*
             * Set device position.
             */
            
            self.devicePosition = device.position;
            
        }
    }
    
}

@end
