//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by test on 11/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var todoItems : [Todo]
    
    @State private var title : String  = ""
    private var isFormEmpty:Bool{
        !title.isEmptyOrWhiteSpace
    }
    
    private var pendingToDoItems :[Todo]{
        todoItems.filter {
            !$0.isComepte
        }
    }
    
    
    private var completedToDoItems :[Todo]{
        todoItems.filter {
            $0.isComepte
        }
    }
    
    func saveToDoList(_ title: String){
        // create the item
        let item = Todo(title: title, isComepte: false)
        // add the item to data context
        context.insert(item)
    }
    
    func updateTodoItem(_ todoItem: Todo){
        try? context.save()
    }
    
    func deleteTodoItem(_ todoItem:Todo){
        context.delete(todoItem)
    }
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if isFormEmpty{
                            saveToDoList(title)
                            title = ""
                        }
                    }
                
                List{
                    Section("Pending") {
                        if pendingToDoItems.isEmpty{
                            ContentUnavailableView("No items founds", image: "doc")
                        }else{
                            ForEach(pendingToDoItems) { todoItem in
                                TodoCellView(todoItem: todoItem, onChange: updateTodoItem)
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { index in
                                    let todoItem = pendingToDoItems[index]
                                    deleteTodoItem(todoItem)
                                }
                            }
                        }
                    }
                    
                    Section("Complete") {
                        if completedToDoItems.isEmpty{
                            ContentUnavailableView("No items founds", image: "doc")
                        }else{
                            ForEach(completedToDoItems) { todoItem in
                                TodoCellView(todoItem: todoItem, onChange: updateTodoItem)
                            }.onDelete { indexSet in
                                indexSet.forEach { index in
                                    let todoItem = completedToDoItems[index]
                                    deleteTodoItem(todoItem)
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                
                
            }
            .padding()
            .navigationTitle("Todo")
            
        }
       
    }
}

struct TodoCellView:View {
    
    let todoItem : Todo
    let onChange : (Todo)->Void
    
    var body: some View {
        HStack{
            Image(systemName: todoItem.isComepte ? "checkmark.square": "square")
                .onTapGesture {
                    todoItem.isComepte.toggle()
                    onChange(todoItem)
                }
            
            if todoItem.isComepte{
                Text(todoItem.title)
            }else{
                TextField("", text: Binding(get: {
                    todoItem.title
                }, set: { newVal in
                    todoItem.title = newVal
                }))
                .onSubmit {
                    onChange(todoItem)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
