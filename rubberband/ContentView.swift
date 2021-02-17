
import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 180, height: 180)
                .foregroundColor(.red)
                .opacity(0.15)
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
                .rubberDrag(dragLimit: 60)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
