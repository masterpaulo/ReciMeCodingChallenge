//
//  RecipeListView.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject private var viewModel: RecipeListViewModel = RecipeListViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
       
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid  (columns: columns, spacing: 10) {
                ForEach(viewModel.recipeList, id: \.self) { item in
                    VStack{
                        ZStack(alignment: .bottom) {
                            Image("")
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .background(Color.gray)
                                .cornerRadius(10)
                            
                            HStack {
                                Text("40m")
                                Spacer()
                                Text("122")
                            }
                            .padding(10)
                        }
                        
                        HStack {
                            Text(item)
                            Spacer()
                        }
                        .padding(.horizontal, 4)
                        
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
