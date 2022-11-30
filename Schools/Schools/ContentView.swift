//
//  ContentView.swift
//  Schools
//
//  Created by Jongwook Park on 2022/11/30.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedMenuItemID: MenuItem.ID?
    @State private var selectedSchoolItemID: SchoolItem.ID?
    
    var body: some View {
        
        NavigationSplitView {
            // 메뉴 바
            List(menuItems, selection: $selectedMenuItemID) { menuItem in
                Text(menuItem.name)
            }
        } content: {
            // 서브 메뉴
            List(schoolItems, selection: $selectedSchoolItemID) { schoolItem in
                Text(schoolItem.name)
            }
        } detail: {
            // 서브 메뉴에서 선택된 세부 콘텐츠
            SchoolDetailView(schoolID: selectedSchoolItemID)
        }

    }
}

struct SchoolDetailView: View {
    let schoolID: SchoolItem.ID?
    
    var schoolItem: SchoolItem? {
        get {
            for tempSchoolItem in schoolItems {
                if tempSchoolItem.id == schoolID {
                    return tempSchoolItem
                }
            }
            
            return nil
        }
    }
    
    var body: some View {
        VStack {
            Text(schoolItem?.description ?? "")
        }
        .navigationTitle(schoolItem?.name ?? "")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 14 Pro",  "iPad mini (6th generation)"], id:\.self) { deviceName in
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
