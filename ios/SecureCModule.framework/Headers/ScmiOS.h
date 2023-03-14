//
//  ScmiOs_hpp
//  AntelopScm
//
//  Created by Mohamed Taieb on 17/04/2018.
//  Copyright © 2018 Antelop Solutions. All rights reserved.
//

#ifndef ScmiOs_hpp
#define ScmiOs_hpp

#if defined(__cplusplus)

#include "BinaryStringLight.h"

class ScmiOS {

private:
    const char *getIdentifierForVendor();

public:
    __attribute__((visibility("default")))
    ScmiOS();

    __attribute__((visibility("default")))
    ~ScmiOS();


    __attribute__((visibility("default")))
    void initialize();

    __attribute__((visibility("default")))
    int le();

    __attribute__((visibility("default")))
    int spn(char *packageName, char *applicationDataDirectory);


    __attribute__((visibility("default")))
    BinaryStringLight *m(int commandId,
                    int messageType,
                    BinaryStringLight *payloadBsl,
                    BinaryStringLight *currentPasscodeBsl,
                    BinaryStringLight *nextPasscodeBsl,
                    BinaryStringLight *scmProtectionCodeBsl,
					int sensitiveInputJsonDataElementCount,
                    BinaryStringLight **sensitiveInputJsonData);

    __attribute__((visibility("default")))
    BinaryStringLight *p1(BinaryStringLight *cryptogram,
                                  int keyIndex,
                                  int emvMethod,
                                  int authenticationMethodType,
                                  BinaryStringLight *passcode,
                                  bool clearKey);
};

#endif /* C++ */
#endif /* ScmiOs_hpp */
