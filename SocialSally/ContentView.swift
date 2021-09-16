//
//  ContentView.swift
//  SocialSally
//
//  Created by Eddie Gear on 16/09/21.
//

import SwiftUI



struct ContentView: View {
    @FetchRequest(entity: Sally.entity(), sortDescriptors: []) var sallies: FetchedResults<Sally>
    @State var showingAddSally = false
    @Environment(\.managedObjectContext) var moc
   // @State private var image: Image?
   // @State private var inputImage: UIImage?
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    
    @State var twitterValue: Bool = false
    @State var linkedinValue : Bool = false
    @State var color = Color.white
    
    @State private var isShowPhotoLibrary = false
     @State private var image = UIImage()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sallies, id: \.authorNote) { sally in
                    SallyCard(sally: sally)
                    
                    Text(sally.hashtags ?? "")
                }
                .onDelete(perform: removeJokes)
            }
            .navigationBarTitle("Social Posts")
            .navigationBarItems(leading: EditButton(), trailing: Button("Add") {
                self.showingAddSally.toggle()
            })
        }
        .sheet(isPresented: $showingAddSally) {
            AddView(isPresented: self.$showingAddSally).environment(\.managedObjectContext, self.moc)
        }
    }
    
    
    
    func removeJokes(at offsets: IndexSet) {
        for index in offsets {
            let sally = sallies[index]
            moc.delete(sally)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
