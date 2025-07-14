
import SwiftUI

struct ContentView: View {
    @State var responses: [Response] = []
    var scorer = Scorer()
    
    func saveResponce(text: String) {
        let score = scorer.score(text)
        let response = Response(text: text, score: score)
        responses.insert(response, at: 0)
    }
    
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
                saveResponce(text: response)
            }
        }
        .padding(.horizontal)
        .background(Color(white: 0.94))
    }
}

#Preview {
    ContentView()
}
