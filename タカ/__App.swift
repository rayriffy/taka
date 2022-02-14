//
//  __App.swift
//  タカ
//
//  Created by rayriffy on 2022/02/15.
//

import SwiftUI

@main
struct __App: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

extension String {
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
  }
}
