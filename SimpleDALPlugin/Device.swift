//
//  Device.swift
//  SimpleDALPlugin
//
//  Created by 池上涼平 on 2020/04/25.
//  Copyright © 2020 com.seanchas116. All rights reserved.
//

import Foundation

class Device: Object {
    let name = "SimpleDALPlugin"

    func hasProperty(address: CMIOObjectPropertyAddress) -> Bool {
        switch (Int(address.mSelector)) {
        case kCMIOObjectPropertyName:
            return true

        default:
            return false
        }
    }

    func isPropertySettable(address: CMIOObjectPropertyAddress) -> Bool {
        return false
    }

    func getPropertyDataSize(address: CMIOObjectPropertyAddress) -> UInt32 {
        switch (Int(address.mSelector)) {
        case kCMIOObjectPropertyName:
            return UInt32(MemoryLayout<CFString>.size)
        default:
            return 0
        }
    }

    func getPropertyData(address: CMIOObjectPropertyAddress, dataSize: inout UInt32, data: UnsafeMutableRawPointer) {
        dataSize = getPropertyDataSize(address: address)

        switch (Int(address.mSelector)) {
        case kCMIOObjectPropertyName:
            let cfName = name as CFString
            UnsafeMutablePointer<CFString>(OpaquePointer(data)).pointee = cfName
        default: break
        }
    }

    func setPropertyData(address: CMIOObjectPropertyAddress, data: UnsafeRawPointer) {
    }
}