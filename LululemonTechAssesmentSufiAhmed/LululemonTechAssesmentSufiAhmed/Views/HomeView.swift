//
//  ContentView.swift
//  LululemonTechAssesmentSufiAhmed
//
//  Created by Sufiyan Ahmed on 5/10/23.
//

import SwiftUI

struct HomeView: View {
    var garmentManager = GarmentStoreManger()
    var homeViewModel = HomeViewModel()
    @State var garments: [Garment] = []
    
    private func getAllGarments()  -> [Garment] {
        return garmentManager.fetchGarments()
    }
    
    @State private var segment: SegControl = .alphabetic
    var segmentNames: [SegControl] = [.alphabetic, .date]
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemRed
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(Title.sortOrder.rawValue, selection: $segment) {
                    ForEach(segmentNames, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                List {
                    ForEach(garments, id: \.self) { garment in
                        if let name = garment.garmentName {
                            NavigationLink(destination: AddGarmentPageView(garment: garment, garmentManager: garmentManager, name: name)) {
                                Text(name)
                            }
                        }
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let garment = garments[index]
                            garmentManager.deleteGarment(clothes: garment)
                            garments.remove(at: index)
                            self.garments = homeViewModel.sortedResults(segment: segment, array: garments)
                        }
                    })
                } // List
            } // VStack
            .padding()
            .navigationTitle("List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddGarmentPageView(garment: nil, garmentManager: garmentManager)) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .onAppear {
                garments = []
                garments = getAllGarments()
                self.garments = homeViewModel.sortedResults(segment: segment, array: garments)
            }
            .onChange(of: segment) { newValue in
                self.garments = homeViewModel.sortedResults(segment: newValue, array: garments)
            }
        } // NavView
    } //body
    
}

extension HomeView {
    enum Title: String {
        case navigationTitle = "List"
        case sortOrder = "Sort Order"
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
