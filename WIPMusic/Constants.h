#import <Foundation/Foundation.h>


/* =======================  Device Size ====================*/
#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width

#define widthCalculate(w) (([[UIScreen mainScreen] bounds].size.width) * (w / 320.0))

#define heightCalculate(h) (([[UIScreen mainScreen] bounds].size.height) * (h / 568.0))

//========== BASE URL ==========================
#define SERVER_ENDPOINT @"http://wip-api.westeurope.cloudapp.azure.com/"
#define ACCESS_TOKEN @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjI0ODQ1ODMxMDYsImEzcy5hcHBfaWQiOjgsImEzcy5vd25lcl90eXBlIjoiVXNlciIsImEzcy5vd25lcl9pZCI6IjQifQ.32kfbtLK7yCe5Q9rDdmGpWBXtJDhXCOaIz_K5DPdeEA"

