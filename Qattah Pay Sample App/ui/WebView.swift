//
//  MainView.swift
//  Qattah Pay Sample App
//
//  Created by khlafawi on 01/01/2023.
//
//

import SwiftUI
import WebKit

struct WebView: View {

    // MARK: - Properties
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        NavigationView {
            VStack {
                webView(viewModel: viewModel)
            }
        }
    }
}

struct webView: UIViewRepresentable {

    typealias UIViewType = WKWebView
    let webView: WKWebView

    init(viewModel: MainViewModel) {

        let requiredUrl = (viewModel.apiResponse?.links?.redirect_to)!.replacingOccurrences(of: "http://localhost/", with: "https://staging.qattahpay.sa/")
        webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(string: requiredUrl)!))

        viewModel.startListener(onPaidSuccessfully: {
            print("Payment succeeded")
        })
    }

    func makeUIView(context: Context) -> WKWebView {
        webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
