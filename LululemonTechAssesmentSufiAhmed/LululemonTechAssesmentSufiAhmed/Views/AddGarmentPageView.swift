//
//  AddGarmentPageView.swift
//  LululemonTechAssesmentSufiAhmed
//
//  Created by Sufiyan Ahmed on 5/10/23.
//

import SwiftUI
import CoreData

struct AddGarmentPageView: View {
    @Environment(\.presentationMode) var presentationMode
    let garment: Garment?
    
    var garmentManager: GarmentStoreManger
    @State private var isDisabled: Bool = true
    @State var name: String = ""
    
    var body: some View {
        VStack {
           Text("Garment Name: ")
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            
            TextField("Enter garment name", text: $name)
                .foregroundColor(.black)
                .padding([.leading, .trailing], 25)
                .padding(.top, 10)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
        } //VStack
        .onChange(of: name) { _ in  // onChange logic for when user tries to save with empty textfield
            if !name.isEmpty {
                isDisabled = false
            } else {
                isDisabled = true
            }
        }
        .navigationTitle("ADD")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {  //saving new garment details
                    if garment == nil {
                        garmentManager.addNewGarment(name)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        if !name.isEmpty {
                            garment?.garmentName = name
                            garmentManager.updateGarment()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .disabled(isDisabled)
            }
        }
    } //body
}

struct AddGarmentPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddGarmentPageView(garment: nil, garmentManager: GarmentStoreManger())
    }
}
