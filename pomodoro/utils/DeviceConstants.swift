import UIKit

enum DeviceType: Int {
    case iPad
    case iPhone

    case unknownDevice
}

enum DeviceModelScreen: Int {
    case iPad_Pro_New
    case iPad_Pro

    case iPhone14
    case iPhone14_Pro
    case iPhone14_Pro_Max
    case iPhone15
    case iPhone15_Pro
    case iPhone15_Pro_Max
    case iPhone16
    case iPhone16_Pro
    case iPhone16_Pro_Max

    case unknown_MODEL


    func deviceType() -> DeviceType {
        switch self {
        case .iPad_Pro_New, .iPad_Pro:
            return .iPad
        case .iPhone14, .iPhone15, .iPhone16, .iPhone14_Pro, .iPhone14_Pro_Max, .iPhone15_Pro, .iPhone15_Pro_Max, .iPhone16_Pro, .iPhone16_Pro_Max:
            return .iPhone
        case .unknown_MODEL:
            return .unknownDevice
        }
    }

    func screenHeight() -> CGFloat {
        switch self {
        case .iPhone14:      return 844
        case .iPhone15:      return 844
        case .iPhone16:      return 844
        case .iPhone14_Pro:  return 852
        case .iPhone14_Pro_Max:      return 932
        case .iPhone15_Pro:     return 852
        case .iPhone15_Pro_Max:      return 932
        case .iPhone16_Pro:      return 882
        case .iPhone16_Pro_Max:      return 1002
        case .iPad_Pro_New: return 1112
        case .iPad_Pro:     return 1366

        case .unknown_MODEL:    return DeviceConstants.screenHeight()
        }
    }

    static func deviceModelList() -> [DeviceModelScreen] {
        var models = [DeviceModelScreen]()

        var i = 0
        while let model = DeviceModelScreen(rawValue: i) {
            models.append(model)
            i += 1
        }

        return models
    }
}

struct DeviceConstants {

    static func deviceType() -> DeviceType {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:      return .iPad
        case .phone:    return .iPhone
        default:        return .unknownDevice
        }
    }

    static func deviceModelScreen() -> DeviceModelScreen {
        let currentDeviceType = DeviceConstants.deviceType()
        let validModels = DeviceModelScreen.deviceModelList().filter({ $0.deviceType() == currentDeviceType })

        let currentScreenHeight = DeviceConstants.screenHeight()
        if let model = validModels.filter({ $0.screenHeight() == currentScreenHeight }).first {
            return model
        }

        if UIDevice.current.model.hasPrefix("iPhone") {
            return .iPhone14
        }

        return .unknown_MODEL
    }

    static func screenHeight() -> CGFloat {
        return max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
    }
}
