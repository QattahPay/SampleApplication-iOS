//
//  Qattah_Pay_Sample_AppApp.swift
//  Qattah Pay Sample App
//
//  Created by khlafawi on 01/01/2023.
//
//

import SwiftUI

@main
struct QattahPaySampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
}
