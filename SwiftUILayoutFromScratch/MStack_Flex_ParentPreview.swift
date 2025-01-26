import SwiftUI

#Preview("ParentFrame has less tall size, with ScrollView") {
    VStack(spacing: 150) {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                Text("aa")
                Rectangle().fill(.red)
                    .frame(width: 50, height: 200)
            }
            ScrollView(.horizontal) {
                MyHStack(spacing: 10) {
                    Text("aa")
                    Rectangle().fill(.yellow)
                        .frame(width: 50, height: 200)
                }
            }
        }
    }
}

#Preview("Text and Rectagnle in ScrollView") {
    VStack(spacing: 10) {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                Text("a")
                Rectangle().fill(.red)
                Text("a")
                Rectangle().fill(.red)
            }
        }
        
        ScrollView(.horizontal) {
            MyHStack(spacing: 10) {
                Text("a")
                Rectangle().fill(.green)
                Text("a")
                Rectangle().fill(.green)
            }
        }
    }
}

#Preview("Hstack with ScrollView") {
    VStack {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
            }
        }
        
        ScrollView(.horizontal) {
            MyHStack(spacing: 0) {
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
            }
        }
    }
}

#Preview("Spacer in ScrollView") {
    VStack(spacing: 0) {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                Rectangle().fill(.red)
                Spacer()
                Rectangle().fill(.blue)
                Spacer()
                Rectangle().fill(.red)
                Spacer()
                Rectangle().fill(.blue)
            }
        }
        ScrollView(.horizontal) {
            MyHStack(spacing: 10) {
                Rectangle().fill(.green)
                Spacer()
                Rectangle().fill(.yellow)
                Spacer()
                Rectangle().fill(.green)
                Spacer()
                Rectangle().fill(.yellow)
            }
        }
    }
}

#Preview("Hstack with ScrollView, min Max") {
    VStack {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                Rectangle()
                    .frame(minWidth: 50)
                    .foregroundStyle(Color.red)
                Rectangle()
                    .frame(idealWidth: 50)
                    .foregroundStyle(Color.blue)
                Rectangle()
                    .frame(maxWidth: 100)
                    .foregroundStyle(Color.red)
                Rectangle()
                    .frame(minWidth: 50, maxWidth: 100)
                    .foregroundStyle(Color.blue)
                Rectangle()
                    .frame(minWidth: 50, idealWidth: 100)
                    .foregroundStyle(Color.red)
                Rectangle()
                    .frame(idealWidth: 100, maxWidth: 150)
                    .foregroundStyle(Color.blue)
                Rectangle()
                    .frame(minWidth: 50, idealWidth: 100, maxWidth: 150)
                    .foregroundStyle(Color.red)
                Rectangle()
                    .foregroundStyle(Color.blue)
            }
        }
        
        ScrollView(.horizontal) {
            MyHStack(spacing: 0) {
                Rectangle()
                    .frame(minWidth: 50)
                    .foregroundStyle(Color.yellow)
                Rectangle()
                    .frame(idealWidth: 50)
                    .foregroundStyle(Color.green)
                Rectangle()
                    .frame(maxWidth: 100)
                    .foregroundStyle(Color.yellow)
                Rectangle()
                    .frame(minWidth: 50, maxWidth: 100)
                    .foregroundStyle(Color.green)
                Rectangle()
                    .frame(minWidth: 50, idealWidth: 100)
                    .foregroundStyle(Color.yellow)
                Rectangle()
                    .frame(idealWidth: 100, maxWidth: 150)
                    .foregroundStyle(Color.green)
                Rectangle()
                    .frame(minWidth: 50, idealWidth: 100, maxWidth: 150)
                    .foregroundStyle(Color.yellow)
                Rectangle()
                    .foregroundStyle(Color.green)
            }
        }
    }
}
