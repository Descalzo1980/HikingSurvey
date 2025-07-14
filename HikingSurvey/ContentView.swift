
import SwiftUI

let EMPTY_STRING = ""

struct ContentView: View {
    @FocusState private var textFieldFocused: Bool
    @State var responses: [Response] = []
    @State private var responseText = ""
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
            HStack {
                TextField("What do you think about hiking?", text: $responseText)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(5)
                Button("Done") {
                    guard !responseText.isEmpty else { return }
                    saveResponce(text: responseText)
                    responseText = EMPTY_STRING
                    textFieldFocused = false
                }
                .padding(.horizontal, 4)
            }
            .padding(.bottom, 8)
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
