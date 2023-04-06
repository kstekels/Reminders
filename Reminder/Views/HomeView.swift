//
//  ContentView.swift
//  Reminder
//
//  Created by karlis.stekels on 31/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var search: String = ""
    @State private var searching: Bool = false
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults : FetchedResults<Reminder>
    
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    MyListView(myLists: myListResults)
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
                .onChange(of: search, perform: { searchTerm in
                    searching = !searchTerm.isEmpty ? true : false
                    searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
                })
                .overlay(alignment: .center, content: {
                    ReminderListView(reminders: searchResults)
                        .opacity(searching ? 1.0 : 0.0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        AddNewListView { name, color in
                            //TODO: - Save the list to DB
                            do {
                                try ReminderService.saveMyList(name, color)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }.padding()
            }
            
        }.searchable(text: $search)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistantContainer.viewContext)
    }
}
