//
//  RoomsSceneView.swift
//  TZ_Hotel
//
//  Created by Иван Конищев on 29.09.2023.
//

import SwiftUI
import UIKit

struct RoomsSceneView: View
{
    @EnvironmentObject var coordinator: Coordinator
    @State private var selectedIndex: Int? = nil
    let sceneTitle: String
    
    @ObservedObject var viewModel: RoomsViewMoedel
    @State private var index: [Int] = [0,0]
    
    var body: some View
    {
        VStack
        {
            if viewModel.viewData.count > 0
            {
                ScrollView
                {
                    VStack(spacing: 0)
                    {
                        
                        ForEach(0..<viewModel.viewData.count, id: \.self) { modelIndex in
                            Group {
                                VStack(alignment: .leading,spacing: 0)
                                {
                                    CarouselImage(item: viewModel.viewData[modelIndex].imgData)
                                        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                                    
                                    Text(viewModel.viewData[modelIndex].name)
                                        .font(Constants.Fonts.sfpro22Regular)
                                        .foregroundColor(.black)
                                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                                    
                                    peculiarties(viewModel.viewData[modelIndex].peculiarties)
                                    
                                    buttonInfo()
                                    
                                    HStack(alignment: .bottom)
                                    {
                                        Text(String(viewModel.moneyPresent(modelIndex)))
                                            .font(Constants.Fonts.sfpro30Medium)
                                        Text(viewModel.viewData[modelIndex].priceDescription)
                                            .font(Constants.Fonts.sfpro14Light)
                                            .foregroundColor(Constants.Colors.greyTintColor)
                                            .padding(5)
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    
                                    SelectedButton(buttonText: "Выбрать номер", action: {
                                        coordinator.push(.booking)
                                    })
                                }
                                .background(Color.white)
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                                .cornerRadius(12)
                                
                            }
                        }
                        
                    }
                    .background(Constants.Colors.basicBackground)
                    
                }
            } else
            {
                ProgressView("Load....")
                    .onAppear {
                        viewModel.fetchData()
                    }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack{
                    Text(sceneTitle)
                        .font(Constants.Fonts.headline1)
                        .foregroundColor(Color.black)
                }
            }
        }
    }
    
    // MARK: - button info
    @ViewBuilder private func buttonInfo() -> some View
    {
        VStack{
            Button {
                // Some Action
            } label: {
                HStack(alignment: .center)
                {
                    Text("Подробнее о номере")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .foregroundColor(Constants.Colors.buttonBlueTint)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 12)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .foregroundColor(Constants.Colors.buttonBlueTint)
                }
            }
            .frame(height: 29)
            .background(Constants.Colors.buttonBackGRopac10)
            .cornerRadius(5)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
    }
    
    @ViewBuilder private func peculiarties(_ data: [String]) -> some View {
        VStack (alignment: .leading)
        {
            ForEach(0..<data.count, id: \.self) { index in
                VStack{
                    Text(data[index])
                        .font(Constants.Fonts.sfpro16Regular)
                        .foregroundColor(Constants.Colors.greyTintColor)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                .frame(height: 29)
                .background(Constants.Colors.backGroundPeculiarities)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        
    }
}


//struct RoomsSceneView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainSceneView(viewModel: MainViewModel(service: AlamofierService<HotelParseModel>()))
//    }
//}
