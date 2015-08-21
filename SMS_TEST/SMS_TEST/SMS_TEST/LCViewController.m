//
//  LCViewController.m
//  SMS_TEST
//
//  Created by LcGero on 15/8/17.
//  Copyright (c) 2015年 LcGero. All rights reserved.
//

#import "LCViewController.h"
#import <SMS_SDK/SMS_SDK.h>

@interface LCViewController ()
@property (nonatomic, strong) NSString *localeAreaCode;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) NSMutableArray *areaArray;
@property (nonatomic, strong) NSString *defultAreaCode;
@property (nonatomic, unsafe_unretained) BOOL isNumIlegal;
@property (nonatomic, unsafe_unretained) NSInteger time;
@end

@implementation LCViewController
//提交验证码
- (IBAction)commitVerifyCode:(id)sender {
    [SMS_SDK commitVerifyCode:self.verificationCodeTF.text result:^(enum SMS_ResponseState state) {
        if(self.verificationCodeTF.text.length!=4)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"notice"
                                                            message:@"verifycodeformaterror"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            
            [SMS_SDK commitVerifyCode:self.verificationCodeTF.text result:^(enum SMS_ResponseState state) {
                if (SMS_ResponseStateSuccess == state)
                {
                    NSLog(@"验证成功");
                    NSString* str = [NSString stringWithFormat:NSLocalizedString(@"verifycoderightmsg", nil)];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"verifycoderighttitle", nil)
                                                                    message:str
                                                                   delegate:self
                                                          cancelButtonTitle:@"sure"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                }
                else if(SMS_ResponseStateFail == state)
                {
                    NSLog(@"验证失败");
                    NSString* str = [NSString stringWithFormat:@"verifycodeerrormsg"];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"verifycodeerrortitle"
                                                                    message:str
                                                                   delegate:self
                                                          cancelButtonTitle:@"sure"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                }
            }];
        }
    }];
}
//发送验证码
- (IBAction)registeUser:(id)sender {
    [self getLocalAreaCode];
    [self verificationPhoneNum:self.phoneNumTF.text areaCode:self.phoneNumTF.text];
   
    if (_isNumIlegal) {
//        NSString *phoneNum = [_defultAreaCode stringByAppendingString:self.phoneNumTF.text];
//        NSLog(@"%@",phoneNum);
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.phoneNumTF.text zone:_defultAreaCode result:^(SMS_SDKError *error) {
        if (!error)
        {
            _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
            NSLog(@"验证码发送成功");
           
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"短信发送失败"
                                                            message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
}

- (void)showTime{
    if (_time) {
   
    self.timeLabel.text = [NSString stringWithFormat:@"%d",_time];
        _time--;}
    else{
        [_myTimer invalidate];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phoneNumTF resignFirstResponder];
    [self.verificationCodeTF resignFirstResponder];
}
//得到区号
- (void)getLocalAreaCode{
            NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    
            NSString *areaCode = [locale objectForKey:NSLocaleCountryCode];

    NSDictionary *dictCodes = [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
                               @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                               @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                               @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                               @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                               @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                               @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                               @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                               @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                               @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                               @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                               @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                               @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                               @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                               @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                               @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                               @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                               @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                               @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                               @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                               @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                               @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                               @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                               @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                               @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                               @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                               @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                               @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                               @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                               @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                               @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                               @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                               @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                               @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                               @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                               @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                               @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                               @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                               @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                               @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                               @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                               @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                               @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                               @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                               @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                               @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                               @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                               @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                               @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                               @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                               @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                               @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                               @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                               @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                               @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                               @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                               @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                               @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                               @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                               @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                               @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    _defultAreaCode = dictCodes[areaCode];
    _localeAreaCode = areaCode;
    
}
//判断手机号是否合法
- (void)verificationPhoneNum:(NSString*)phoneNum areaCode:(NSString*)areaCode{
    for (NSDictionary *dic in _areaArray) {
        NSString *str = [dic objectForKey:@"zone"];
        if ([str isEqualToString:_defultAreaCode]) {
           
            NSString *rule = dic[@"rule"];
           
            NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule];
            BOOL isMatch = [pred evaluateWithObject:self.phoneNumTF.text];
            if (!isMatch)
            {
                //手机号码不正确
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"注意"
                                                                message:@"输入号码有误"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            else{
                _isNumIlegal = YES;
            }
          
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isNumIlegal = NO;
    _time = 60;
    [SMS_SDK getZone:^(enum SMS_ResponseState state, NSArray *zonesArray) {
        if (state == SMS_ResponseStateSuccess) {
            NSLog(@"获取区号成功");
            _areaArray = [NSMutableArray arrayWithArray:zonesArray];
      
        }
        else{
            NSLog(@"获取区号失败");
        }
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
