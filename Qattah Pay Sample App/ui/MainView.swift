//
// Created by khlafawi on 13/01/2023.
//

import SwiftUI

struct MainView: View {

    // MARK: - Properties
    @ObservedObject var viewModel: MainViewModel

    // MARK: - View
    var body: some View {
        NavigationView {
            HStack {
                Spacer()

                VStack {

                    NavigationLink(destination: WebView(viewModel: viewModel), isActive: $viewModel.navigate) {
                        EmptyView()
                    }

                    VStack {

                        Text("Qattah Pay Sample Application")
                                .font(.title)
                                .fixedSize()
                                .lineSpacing(CGFloat(5))
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

                        Text("This application is for showing the technical integration in Android to request a new Qattah Pay order. \\n As a user I will reach this page after selecting my products that I want to purchase and then click on \\'Pay with Qattah\\'")
                                .font(.body)
                                .padding()

                        TextField("Ord_123", text: $viewModel.reference)
                                .frame(height: 40)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                ).padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))

                        TextField("https://merchant.com/callback", text: $viewModel.callback_url)
                                .frame(height: 40)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                ).padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))

                        HStack {
                            TextField("100.00", text: $viewModel.amount)
                                    .frame(height: 40)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 2)
                                    ).padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))

                            Text("SAR")
                                    .font(.title2)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

                        }
                        Group {
                            if viewModel.isLoading {
                                ProgressView()
                                        .progressViewStyle(.circular)
                            } else {
                                Button(action: {
                                    viewModel.pay()
                                }, label: {
                                    Text("Pay with Qattah Pay")
                                            .fontWeight(.bold)
                                            .frame(width: 300, height: 40)
                                            .foregroundColor(.blue)
                                            .overlay(RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.blue, lineWidth: 2)
                                            )
                                })
                            }

                        }
                                .frame(maxHeight: .infinity, alignment: .bottom)

                        Spacer()
                    }
                            .disabled(viewModel.isLoading)
                }
                        .padding()
                        .frame(maxWidth: 400.0)

                Spacer()
            }
                    .alert(isPresented: $viewModel.hasError) {
                        Alert(
                                title: Text("API Request Failed"),
                                message: Text("Unknown error occurred")
                        )
                    }
        }
    }
}
