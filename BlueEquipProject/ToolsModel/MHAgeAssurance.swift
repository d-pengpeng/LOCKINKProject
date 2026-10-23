//
//  MHAgeAssurance.swift
//  BlueEquipProject
//
//  Apple Declared Age Range（Age Assurance）接入封装
//  iOS 26.0 及以上生效，低版本返回 unavailable
//

import UIKit
import DeclaredAgeRange

@objcMembers
@objc(MHAgeAssurance)
final class MHAgeAssurance: NSObject {

    private enum DefaultsKey {
        static let status = "mh_age_assurance_status"
        static let lowerBound = "mh_age_assurance_lower"
        static let upperBound = "mh_age_assurance_upper"
        static let isAdult = "mh_age_assurance_is_adult"
        static let checkedAt = "mh_age_assurance_checked_at"
    }

    /// 成人年龄门槛
    @objc static let adultAgeGate: Int = 18

    @objc static let shared = MHAgeAssurance()

    /// 最近一次确认的成年标识（默认 NO）
    @objc static var isAdultConfirmed: Bool {
        UserDefaults.standard.bool(forKey: DefaultsKey.isAdult)
    }

    /// 最近一次状态：none/unavailable/sharing/declined/error
    @objc static var assuranceStatus: String {
        UserDefaults.standard.string(forKey: DefaultsKey.status) ?? "none"
    }

    /// 已明确共享年龄但未满 18 岁（仅 sharing 状态下成立，其余状态不做拦截）
    @objc static var isAgeRestricted: Bool {
        assuranceStatus == "sharing" && !isAdultConfirmed
    }

    /// 请求年龄区间，completion 均在主线程回调
    /// result 字段：status / lowerBound / upperBound / declaration / parentalControls / error
    @objc func requestAgeRange(from viewController: UIViewController,
                               completion: (([String: Any]) -> Void)?) {
        guard #available(iOS 26.0, *) else {
            Self.persist(status: "unavailable")
            completion?(["status": "unavailable"])
            return
        }

        Task { @MainActor in
            do {
                let response = try await AgeRangeService.shared.requestAgeRange(
                    ageGates: Self.adultAgeGate,
                    in: viewController
                )

                switch response {
                case .sharing(let ageRange):
                    Self.persist(
                        status: "sharing",
                        lowerBound: ageRange.lowerBound,
                        upperBound: ageRange.upperBound
                    )
                    var result: [String: Any] = ["status": "sharing"]
                    result["lowerBound"] = ageRange.lowerBound.map { NSNumber(value: $0) }
                    result["upperBound"] = ageRange.upperBound.map { NSNumber(value: $0) }
                    result["declaration"] = ageRange.ageRangeDeclaration.map { String(describing: $0) } ?? "unknown"
                    result["parentalControls"] = String(describing: ageRange.activeParentalControls)
                    completion?(result)

                case .declinedSharing:
                    Self.persist(status: "declined")
                    completion?(["status": "declined"])

                @unknown default:
                    Self.persist(status: "error")
                    completion?(["status": "error", "error": "unknown"])
                }
            } catch AgeRangeService.Error.invalidRequest {
                Self.persist(status: "error")
                completion?(["status": "error", "error": "invalidRequest"])
            } catch AgeRangeService.Error.notAvailable {
                Self.persist(status: "error")
                completion?(["status": "error", "error": "notAvailable"])
            } catch {
                Self.persist(status: "error")
                completion?(["status": "error", "error": error.localizedDescription])
            }
        }
    }

    private static func persist(status: String,
                                lowerBound: Int? = nil,
                                upperBound: Int? = nil) {
        let defaults = UserDefaults.standard
        defaults.set(status, forKey: DefaultsKey.status)
        defaults.set(Date().timeIntervalSince1970, forKey: DefaultsKey.checkedAt)

        guard status == "sharing" else { return }

        if let lowerBound = lowerBound {
            defaults.set(lowerBound, forKey: DefaultsKey.lowerBound)
        } else {
            defaults.removeObject(forKey: DefaultsKey.lowerBound)
        }
        if let upperBound = upperBound {
            defaults.set(upperBound, forKey: DefaultsKey.upperBound)
        } else {
            defaults.removeObject(forKey: DefaultsKey.upperBound)
        }
        // lowerBound 为 nil 表示低于最低门槛（未成年）
        defaults.set((lowerBound ?? 0) >= adultAgeGate, forKey: DefaultsKey.isAdult)
    }
}
