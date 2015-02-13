//
//  ViewController.m
//  1Первое
//
//  Created by Lowtrack on 13.02.15.
//  Copyright (c) 2015 Vladimir Popov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *navBarlabel;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_myWebView];
    self.url = @"http://1pervoe.ru/mobile.php";
    self.view.autoresizesSubviews = YES;
    NSURL* url = [NSURL URLWithString:self.url];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    self.navBarlabel.text = self.labelNavText;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // Set self as the web view's delegate when the view is shown; use the delegate methods to toggle display of the network activity indicator.
    self.myWebView.delegate = self;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.myWebView stopLoading];	// In case the web view is still loading its content.
    self.myWebView.delegate = nil;	// Disconnect the delegate as the webview is hidden.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // Starting the load, show the activity indicator in the status bar.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];

}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Finished loading, hide the activity indicator in the status bar.
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // Load error, hide the activity indicator in the status bar.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // Report the error inside the webview.
    NSString* errorString = [NSString stringWithFormat:
                             @"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\"><html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'><title></title></head><body><div style='width: 100%%; text-align: center; font-size: 36pt; color: red;'>An error occurred:<br>%@</div></body></html>",
                             error.localizedDescription];
    [self.myWebView loadHTMLString:errorString baseURL:nil];
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
