
import SwiftUI

struct ContentView: View {
    @State var responses: [Response] = []
    
    var body: some View {
        VStack {
            Text("Opinions on Hiking")
                .frame(maxWidth: .infinity)
                .font(.title)
                .padding(.top, 24)
            ScrollView {
                ForEach(responses) {response in
                    ResponseView(response: response)
                }
            }
        }
        .onAppear {
            for response in Response.sampleResponses {
                responses.insert(Response(text: response),at: 0)
            }
        }
        .padding(.horizontal)
        .background(Color(white: 0.94))
    }
}

#Preview {
    ContentView()
}
