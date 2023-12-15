//
//  NetUI.swift
//  regu0005-mad9137-final-project
//
//  Created by Gustavo Reguerin on 2023-12-07.
//

import SwiftUI

struct NetUI: View {
    @EnvironmentObject var networkMonitor : NetworkMonitor
    
    var body: some View {
            if networkMonitor.isConnected {
                //Text("Network is connected")
                ContentView()
            }
            else
            {
                ContentUnavailableView("No network",
                                       systemImage: "wifi.exclamationmark",
                                       description: Text("Check your data or wifi")
                )
            }
    }
}
