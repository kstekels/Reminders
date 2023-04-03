//
//  SelectListView.swift
//  Reminder
//
//  Created by karlis.stekels on 03/04/2023.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListFetchResults: FetchedResults<MyList>
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(myListFetchResults) { myList in
            HStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundColor(Color(myList.color))
                Text(myList.name)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedList = myList
            }
            Spacer()
            if selectedList == myList {
                Image(systemName: "checkmark")
            }
        }
        .listStyle(.plain)
    }
}

struct SelectListView_Previews: PreviewProvider {
    static var previews: some View {
        SelectListView(selectedList: .constant(PreviewData.myList))
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistantContainer.viewContext)
    }
}
