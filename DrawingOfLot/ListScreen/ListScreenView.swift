//
//  ContentView.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 20/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct ListScreenView: View {

  @EnvironmentObject var viewModel: ListScreenViewModel
  
  var body: some View {
    NavigationView {
      Group {
        List {
          ForEach(viewModel.personViewModels) {
            NameListRow().environmentObject($0)
          }
          .onDelete(perform: viewModel.delete)
          NameListAddFooter(textFieldValue: self.$viewModel.nameTextFieldInput,
                            addAction: self.viewModel.addButtonTapped)
        }
        .listStyle(GroupedListStyle())
      }
      .navigationBarTitle("Secret Santa")
      .navigationBarItems(
        leading: Button(
          action: self.viewModel.sendEmails,
          label: {
            Image(systemName: "envelope.badge")
              .padding([.top, .bottom, .trailing], 16)
          }
        ),
        trailing: Button(
          action: self.viewModel.drawButtonTapped,
          label: {
            Image(systemName: "shuffle")
              .padding([.top, .leading, .bottom], 16)
          }
        )
      )
    }
    .onAppear(perform: self.viewModel.viewAppeared)
    .modifier(AdaptsToSoftwareKeyboard())
    .alert(isPresented: self.$viewModel.isErrorAlertPresented) {
      Alert(title: Text("Attention"),
            message: Text("Vous devez ajouter au moins 4 personnes à tirer au sort."),
            dismissButton: Alert.Button.cancel(Text("J'ai compris")))
      
    }
    .actionSheet(isPresented: self.$viewModel.isDeleteJointAlertPresented) {
      ActionSheet(title: Text("Attention"),
                  message: Text("Souhaitez-vous également supprimer le conjoint de cette personne ?"),
                  buttons: [
                    ActionSheet.Button.destructive(Text("Oui"), action: self.viewModel.deleteIncludingJoint),
                    ActionSheet.Button.default(Text("Non"), action: self.viewModel.deleteExcludingJoint),
                    ActionSheet.Button.cancel(Text("Annuler"))
        ]
      )
    }
    .sheet(isPresented: self.$viewModel.isJointViewPresented, content: {
      AddPersonView().environmentObject(AddPersonViewModel())
    })
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let remi = PersonViewModel(name: "Rémi")
    remi.joint = "Camille"
    remi.receiver = "Benjamin"
    let benjamin = PersonViewModel(name: "Benjamin")
    benjamin.joint = "Sandrine"
    benjamin.receiver = "Rémi"
    let nicolas = PersonViewModel(name: "Nicolas")
    nicolas.joint = "Nathalie"
    nicolas.receiver = "Philippe"
    let philippe = PersonViewModel(name: "Philippe")
    philippe.joint = "Marie-France"
    philippe.receiver = "Nicolas"
    let camille = PersonViewModel(name: "Camille")
    camille.joint = "Rémi"
    camille.receiver = "Sandrine"
    let sandrine = PersonViewModel(name: "Sandrine")
    sandrine.joint = "Benjamin"
    sandrine.receiver = "Camille"
    let nathalie = PersonViewModel(name: "Nathalie")
    nathalie.joint = "Nicolas"
    nathalie.receiver = "Marie-France"
    let marieFrance = PersonViewModel(name: "Marie-France")
    marieFrance.joint = "Philippe"
    marieFrance.receiver = "Nathalie"
    
    let viewModel = ListScreenViewModel()
    viewModel.personViewModels = [
      remi,
      camille,
      benjamin,
      sandrine,
      nicolas,
      nathalie,
      philippe,
      marieFrance
    ]
    
    return ListScreenView().environmentObject(viewModel)
  }
}
#endif
