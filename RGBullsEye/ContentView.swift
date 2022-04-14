//
//  ContentView.swift
//  RGBullsEye
//
//  Created by ilya radovilsky on 03.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State var game = Game()
    @State var guess: RGB
    @State var showScore = false
    
    var body: some View {
        VStack {
            ColorCircle(color: game.target)
            if !showScore {
                Text("R: ??? G: ??? B: ???").padding()
            } else {
                Text(game.target.intString())
            }
            ColorCircle(color: guess)
            Text(guess.intString()).padding()
            ColorSlider(value: $guess.red, trackColor: SwiftUI.Color.red)
            ColorSlider(value: $guess.green, trackColor: SwiftUI.Color.green)
            ColorSlider(value: $guess.blue, trackColor: SwiftUI.Color.blue)
            Button(
                action: {showScore = true; game.check(guess: guess)},
                label: {Text("Hit Me!")}
            ).alert(
                isPresented: $showScore,
                content: {
                    Alert(
                        title: Text("Your Score"),
                        message: Text(String(game.scoreRound)),
                        dismissButton: Alert.Button.default(
                            Text("OK"),
                            action: {game.startNewGame(); guess = RGB()}
                        )
                    )
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(guess: RGB())
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var trackColor: Color
    
    var body: some View {
        HStack {
            Text("0")
            Slider(value: $value)           .accentColor(trackColor)
            Text("255")
        }
        .padding(.horizontal)
    }
}

struct ColorCircle: View {
    var color: RGB
    var body: some View {
        Color(rgbSource: color)
    }
}
