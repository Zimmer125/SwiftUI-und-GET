//
//  ContentView.swift
//  GET_TEST
//
//  Created by Cedric Haufe on 12.07.22.
//

import SwiftUI

struct ItemModel :Codable{
    
    let information1: String
    let information2: String
    let information3: String

  
}

func anfordern(userCompletionHandler: @escaping (ItemModel? ,Error?)->Void)
{
    if let url = URL(string: "https://haufevolution.de/GET_TEST.php") {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    var res: ItemModel
                    res = try JSONDecoder().decode(ItemModel.self, from: data)
                    userCompletionHandler(res ,nil)
                    
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
    
}

struct ContentView: View {
    @State var Information = "Hello,World!"
    var body: some View {
        Text(Information)
            .padding()
        Button("Anfordern"){
            anfordern(userCompletionHandler: {user, error in
                
                DispatchQueue.main.async {
                    
                    if let user=user{
                        Information=user.information2
                    }}})
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
