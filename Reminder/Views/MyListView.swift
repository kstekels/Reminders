//
//  MyListView.swift
//  Reminder
//
//  Created by karlis.stekels on 31/03/2023.
//

import SwiftUI

struct MyListView: View {
    
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationView {
            if myLists.isEmpty {
                Spacer()
                Text("No Reminders found")
            } else {
                ForEach(myLists, id: \.self) { myList in
                    NavigationLink(value: myList) {
                        VStack {
                            MyListCellView(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading], 10)
                                .font(.title3)
                            Divider()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self) { myList in
                    MyListDetailView(myList: myList)
                        .navigationTitle(myList.name)
                }
            }
        }
    }
}
