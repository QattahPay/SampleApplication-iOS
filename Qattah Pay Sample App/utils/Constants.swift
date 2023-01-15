//
// Created by khlafawi on 02/01/2023.
//

import Foundation

struct Constants {

    private static let MODE = "production" // or "staging"
    private static let PRODUCTION_SUBDOMAIN = "api"
    private static let STAGING_SUBDOMAIN = "staging-api"
    private static let API_VERSION = "v1"

    static let BASE_PRODUCTION_URL = "https://" + PRODUCTION_SUBDOMAIN + ".qattahpay.sa/api/" + API_VERSION + "/merchant-integration/"
    private static let BASE_STAGING_URL = "https://" + STAGING_SUBDOMAIN + ".qattahpay.sa/api/" + API_VERSION + "/merchant-integration/"

    static let APPLICATION_URL = "https://app.qattahpay.sa/"
    static let PAYMENT_CALLBACK_SOCKET_URL = "http://161.35.70.189:3000/"

    static let ORDER_PAYMENT_STATUS = "payment"

    var qattahPayToken: String = ""
    var qattahBaseUrl = "https://app.qattahpay.sa/"

    static let TOKEN = "1|ffOqAIk0HA71TQd1pLuF8mbb0bUvr8emWY5EI5TR"


//    init() {
////        if (mode == "production") {
////            qattahPayToken = "Bearer ${BuildConfig.QATTAH_PRODUCTION_TOKEN}"
////        } else {
////            qattahPayToken = "Bearer ${BuildConfig.QATTAH_TESTING_TOKEN}"
////        }
////        if (mode == "production") {
////            qattahBaseUrl = BASE_PRODUCTION_URL
////        } else {
////            qattahBaseUrl = BASE_STAGING_URL
////        }
//    }

//    private func getQattahPayToken(mode: String) -> Swift.String {
//        if (mode == "production") {
//            return "Bearer ${BuildConfig.QATTAH_PRODUCTION_TOKEN}"
//        } else {
//            return "Bearer ${BuildConfig.QATTAH_TESTING_TOKEN}"
//        }
//    }

//    private func getBaseUrl(mode: String) -> String {
//        if (mode == "production") {
//            return BASE_PRODUCTION_URL
//        } else {
//            return BASE_STAGING_URL
//        }
//    }
}