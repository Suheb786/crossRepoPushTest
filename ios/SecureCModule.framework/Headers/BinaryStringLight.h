//
//  BinaryStringLight.hpp
//  AntelopScm
//
//  Created by Laurent on 11/06/2018.
//  Copyright © 2018 Antelop Solutions. All rights reserved.
//

#ifndef BinaryStringLight_hpp
#define BinaryStringLight_hpp

#if defined(__cplusplus)

class BinaryStringLight {
    
private:
    unsigned long m_len; // Length of binary string
    unsigned char *m_bin; // Binary data
    
public:

     __attribute__((visibility("default")))
    BinaryStringLight();

    __attribute__((visibility("default")))
    BinaryStringLight(unsigned char *data, unsigned long length);

    __attribute__((visibility("default")))
    ~BinaryStringLight();

    
    __attribute__((visibility("default")))
    unsigned char *getBinaryData();

    __attribute__((visibility("default")))
    unsigned long getLength();
};

#endif /* C++ */
#endif /* BinaryStringLight_hpp */
